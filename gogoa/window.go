package gogoa

// #cgo CFLAGS: -x objective-c
// #cgo LDFLAGS: -framework Cocoa -framework OpenGL -framework QuartzCore
//#include "g_window.h"
import "C"
import "unsafe"

type Window struct {
	ptr unsafe.Pointer
}

func NewWindow() *Window {
	w := new(Window)
	w.ptr = C.NewWindow()

	return w
}

func (self *Window) MakeKeyAndOrderFront() {
	C.MakeKeyAndOrderFront(self.ptr)
}
