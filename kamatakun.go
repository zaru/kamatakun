package main

import (
	"os"
	"os/exec"

	"github.com/zaru/kamatakun/gogoa"
)

func main() {

	// app := gogoa.SharedApplication()
	// window := gogoa.NewWindow()
	// window.MakeKeyAndOrderFront()
	// app.Run()
	if len(os.Args) == 1 {
		cmd := exec.Command(os.Args[0], "--child")
		cmd.Start()
	} else {
		for {
			app := gogoa.SharedApplication()
			window := gogoa.NewWindow()
			window.MakeKeyAndOrderFront()
			app.Run()
		}
	}
}
