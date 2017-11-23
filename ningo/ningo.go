package main

import (
	"fmt"
	"strings"
	"time"
)

func main() {
	p := [][][]string{
		{
			{
				"  _｡＿",
				"　∠　゜＼",
				"　巡＞　　ヽ",
				"　`ー-､　　ヽ",
				"　　　|　　　＼＿＿＿＿",
				"　　∠|∠ヽ　　　　　／",
				"　　　ヽ　　　 ＿　／",
				"￣￣|　 ＼　　|　Ｙ",
				"　　 ￣|/ ＞ーヽ ｜|￣|",
				"　　　　￣￣| |￣￣　 |",
			},
		},
	}

	x := 80
	for _, ll := range p {
		for _, l := range ll {
			for n := range l {
				l[n] = strings.Repeat(" ", x) + l[n]
			}
		}
	}
	x = 0

	for {
		fmt.Print("\x0c")
		for _, pp := range p {
			for _, l := range pp[x%len(pp)] {
				if x < len(l) {
					fmt.Println(string(l[x:]))
				} else {
					fmt.Println()
				}

			}
		}
		time.Sleep(time.Second / 20)
		if x++; x > 165 {
			break
		}
	}
}
