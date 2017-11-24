package main

import (
	"fmt"
	"strings"
	"time"
)

const esc = "\x1b["

func main() {
	// var count int

	c := []string{
		"       _｡＿",
		"     　∠　゜＼",
		"     　巡＞　　ヽ",
		"     　`ー-､　　ヽ",
		"     　　　|　　　＼＿＿＿＿",
		"     　　∠|∠ヽ　　　　　／",
		"     　　　ヽ　　　 ＿　／",
		"     |￣￣|　 ＼　　|　Ｙ",
		"   |￣　　 ￣|/ ＞ーヽ ｜|￣| ",
		"|￣￣　　　　￣￣| |￣￣　   | ",
	}

	w := 80

	for range c {
		fmt.Println()
	}

	for {
		fmt.Printf(esc+"%dA", len(c))
		for _, cc := range c {
			var p string
			if w < 1 {
				s := ^w + 1
				if len(cc) < s {
					p = ""
				} else {
					p = cc[s:]
				}
			} else {
				p = strings.Repeat(" ", w) + cc
			}
			fmt.Printf("%s\n", p)
		}
		w += -1
		if w < -50 {
			break
		}
		time.Sleep(time.Second / 20)
	}
}
