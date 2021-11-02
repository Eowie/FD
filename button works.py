# -*- coding: utf-8 -*-
"""
Created on Sat Oct 23 18:49:15 2021

@author: silam
"""

import tkinter as tk  



def on_button_press(entry):
    on_button_press.value = entry.get()
    entry.quit()


def main():
    root = tk.Tk()
    entry = tk.Entry(root)
    tk.Button(root, text="Get Value!", command=lambda e = entry : on_button_press(e)).pack()
    entry.pack()
    tk.mainloop()
    return on_button_press.value


if __name__ == '__main__':
    val = main()
    print(val)