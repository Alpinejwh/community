//-------------------------------------------------------------------------------
//
// iLED Test
//
// Work in progress support for intelligent or integrated LEDs, commonly known as NeoPixels.
//
// Swift for Arduino (S4A)
// swiftforarduino.com
//
//	Created 19 Mar 2019
//	by Mark Swanson
//
//-------------------------------------------------------------------------------

import AVR

//-------------------------------------------------------------------------------
// Setup
//-------------------------------------------------------------------------------
let rgbLEDPin: UInt8 = 13

pinMode(pin: rgbLEDPin, mode: OUTPUT)

//-------------------------------------------------------------------------------
// Low Level Library API (to be provided by Carl)
//-------------------------------------------------------------------------------
private func iLEDSendBit(pin: UInt8, bit: Bool) {
  
	// Placeholder for private library function
	// ...write bit per sendBit() function at 
	// https://github.com/bigjosh/SimpleNeoPixelDemo/blob/master/SimpleNeopixelDemo/SimpleNeopixelDemo.ino
}
  
//-------------------------------------------------------------------------------
public func iLEDSendByte(pin: UInt8, byte: UInt8) {
  
	// Placeholder for public library function
	// ...shift bits out MSB first
}
  
//-------------------------------------------------------------------------------
// Public Swift API (to become Swift user library)
//-------------------------------------------------------------------------------
func iLEDWritePixel(pin: UInt8, r: UInt8, g: UInt8, b: UInt8, grbOrder: Bool = true) {
  
	// grbOrder=true will send data: green, red, blue for part Numbers : WS2812, WS2813
	// grbOrder=false will send data: red, green, blue for part Numbers: WS2811, 2818
  
	// Each subsequent write pushes last write to next pixel
	// So write pixels in a strip from last to first, 
	// then call show() or just stop sending data and it will latch on it's own after a few uS

	if grbOrder {
		iLEDSendByte(pin: pin, byte: g)
		iLEDSendByte(pin: pin, byte: r)
		iLEDSendByte(pin: pin, byte: b)
	}
	else {
		iLEDSendByte(pin: pin, byte: r)
		iLEDSendByte(pin: pin, byte: g)
		iLEDSendByte(pin: pin, byte: b)
	}
}

//-------------------------------------------------------------------------------
func iLEDShow(pin: UInt8) {
  
  // Show all pixel data recently sent via iLEDWritePixel()
  // TODO: Delay at least xx uS here
}

//-------------------------------------------------------------------------------
func iLEDShowColor (pin: UInt8, r: UInt8, g: UInt8, b: UInt8, count: UInt16, grbOrder: Bool = true) {
	
	// Display a single color on many pixels
	for _ in 1...count {
		iLEDWritePixel(pin: pin, r: r, g: g, b: b, grbOrder: grbOrder)
	}

	iLEDShow(pin: pin)
}

//-------------------------------------------------------------------------------
func iLEDColorWipe (pin: UInt8, r: UInt8, g: UInt8, b: UInt8, count: UInt16, delay: UInt16, grbOrder: Bool = true) {
	
	// Display a single color on many pixels in a sequence one after the other until all are lit
	for numberLit: UInt16 in 0..<count {

		var index: UInt16 = 0

		// Turn on some pixels
		while (index <= numberLit) {
			iLEDWritePixel(pin: pin, r: r, g: g, b: b, grbOrder: grbOrder)
			index = index &+ 1      
		}

		// Turn off the rest of the pixels
		while (index <= count) {
			iLEDWritePixel(pin: pin, r: 0, g: 0, b: 0, grbOrder: grbOrder)          
			index = index &+ 1      
		}

		iLEDShow(pin: pin)
		wait(ms: delay)
	}
}

//-------------------------------------------------------------------------------
func iLEDTheaterChase (pin: UInt8, r: UInt8, g: UInt8, b: UInt8, count: UInt16, delay: UInt16, grbOrder: Bool = true) {
	
	// Theatre style crawling lights

	// TODO: Implement
}

//-------------------------------------------------------------------------------

// ... more cool LED strip effects to come...

//-------------------------------------------------------------------------------
// Main Loop
//-------------------------------------------------------------------------------
while(true) {

	// Test RGB LEDs
	iLEDShowColor (pin: rgbLEDPin, r: 255, g: 0, b: 0, count: 2)
	delay(milliseconds: 500)

	iLEDShowColor (pin: rgbLEDPin, r: 0, g: 255, b: 0, count: 2)
	delay(milliseconds: 500)

	iLEDShowColor (pin: rgbLEDPin, r: 0, g: 0, b: 255, count: 2)
	delay(milliseconds: 500)
}

//-------------------------------------------------------------------------------
