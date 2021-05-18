/*
 * Copyright 2021 Google LLC.
 * SPDX-License-Identifier: Apache-2.0
*/

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <libusb-1.0/libusb.h>

#define USB_VID 0x2ca3
#define USB_PID 0x1f
#define USB_CONFIG 1
#define USB_INTERFACE 3
#define USB_ENDPOINT_VIDEO_IN 0x84
#define USB_ENDPOINT_CONTROL_OUT 0x03
#define USB_BUFFER_SIZE_BYTES 1024

int main(int _argc, char** argv)
{
	// Appease the unused-parameter warning
	(void)_argc;
	int r = libusb_init(NULL);
	if (r < 0) {
		fprintf(stderr, "unable to init libusb: %s\n", libusb_strerror(r));
		exit(1);
	}

	// Get device handle
	libusb_device_handle *dev = libusb_open_device_with_vid_pid(NULL, USB_VID, USB_PID);
	if (dev == NULL){
		libusb_exit(NULL);
		fprintf(stderr, "unable to open device, or device not found\n");
		if (geteuid() != 0) {
			fprintf(stderr, "try running as root (with sudo)\n");
		}
		exit(1);
	}

	// Detach the kernel (all non-fatal)
	r = libusb_reset_device(dev);
	// Detach kernel driver (RNDIS)
	r = libusb_detach_kernel_driver(dev, 0);
	// Detach kernel driver (Storage)
	r = libusb_detach_kernel_driver(dev, 2);
	// Detach kernel driver (Storage)
	r = libusb_detach_kernel_driver(dev, 4);

	// Set active configuration
	r = libusb_set_configuration(dev, USB_CONFIG);
	if (r != 0) {
		fprintf(stderr, "unable to set configuration: (%d) %s\n", r, libusb_strerror(r));
		exit(1);
	}

	// Claim interface
	r = libusb_claim_interface(dev, USB_INTERFACE);
	if (r != 0) {
		fprintf(stderr, "unable to claim interface: %s\n", libusb_strerror(r));
		exit(1);
	}

	// Send magic
	unsigned char MAGIC[] = { 0x52, 0x4d, 0x56, 0x54 };
	int MAGIC_LENGTH = 4;
	unsigned int MAGIC_TIMEOUT_MS = 500;
	r = libusb_bulk_transfer(dev, USB_ENDPOINT_CONTROL_OUT, MAGIC, MAGIC_LENGTH, NULL, MAGIC_TIMEOUT_MS);
	if (r != 0 && r != LIBUSB_ERROR_TIMEOUT) {
		fprintf(stderr, "unable to send magic: %s\n", libusb_strerror(r));
		exit(1);
	}

	// Loooooooooooop
	unsigned char* buf = calloc(USB_BUFFER_SIZE_BYTES, sizeof(char));
	int bytes_read = 0;
	fprintf(stderr, "%s ready\n", argv[0]);
	for (;;) {
		libusb_bulk_transfer(dev, USB_ENDPOINT_VIDEO_IN, buf, USB_BUFFER_SIZE_BYTES, &bytes_read, 0);
		fwrite(buf, sizeof(char), bytes_read, stdout);
		if (bytes_read == 0) {
			break;
		}
	}

	libusb_exit(NULL);
	free(buf);
	return 0;
}
