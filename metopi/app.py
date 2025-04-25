#!/usr/bin/env python3
import tkinter as tk
from tkinter import ttk
import time
import sys
import os
from .sound import generate_beep

class MetopiTimer:
    def __init__(self):
        self.root = tk.Tk()
        self.root.title("Metopi")
        
        # Window setup
        self.root.configure(bg='black')
        self.root.geometry("800x600")
        
        # Variables
        self.time_left = 0
        self.is_running = False
        self.is_fullscreen = False
        self.color_index = 0
        self.colors = [
            "#ffffff",  # Pure white
            "#00e5ff",  # Bright cyan
            "#1ed760",  # Spotify green
            "#ff0055",  # Hot pink
            "#00ff9f",  # Neon mint
            "#7b68ee"   # Medium slate blue
        ]
        
        # Create frames
        self.control_frame = tk.Frame(self.root, bg='black')
        self.control_frame.pack(fill='x', pady=10)
        
        self.display_frame = tk.Frame(self.root, bg='black')
        self.display_frame.pack(expand=True, fill='both')
        
        # Create controls
        self.create_controls()
        self.create_display()
        
        # Bind keyboard shortcuts
        self.bind_events()
    
    def create_controls(self):
        # Time input with modern styling
        time_frame = tk.Frame(self.control_frame, bg='black')
        time_frame.pack(side='left', padx=20)
        
        # Minutes input
        self.minutes_var = tk.StringVar(value="00")
        tk.Entry(
            time_frame,
            textvariable=self.minutes_var,
            font=("Arial", 24),
            width=2,
            bg="#2d2d2d",
            fg=self.colors[0],
            insertbackground=self.colors[1],
            justify='center',
            bd=0
        ).pack(side='left')
        
        tk.Label(
            time_frame,
            text=":",
            font=("Arial", 24, "bold"),
            bg='black',
            fg=self.colors[1]
        ).pack(side='left', padx=2)
        
        # Seconds input
        self.seconds_var = tk.StringVar(value="00")
        tk.Entry(
            time_frame,
            textvariable=self.seconds_var,
            font=("Arial", 24),
            width=2,
            bg="#2d2d2d",
            fg=self.colors[0],
            insertbackground=self.colors[1],
            justify='center',
            bd=0
        ).pack(side='left')
        
        # Control buttons
        button_frame = tk.Frame(self.control_frame, bg='black')
        button_frame.pack(side='right', padx=20)
        
        # Button style with modern effects
        button_style = {
            "font": ("Arial", 14),
            "bg": "#2d2d2d",
            "fg": self.colors[0],
            "width": 3,
            "bd": 0,
            "padx": 10,
            "activebackground": "#3d3d3d",
            "activeforeground": self.colors[1],
            "cursor": "hand2",
            "relief": "flat",
            "highlightthickness": 0
        }
        
        # Start/Pause button
        self.start_button = tk.Button(
            button_frame,
            text="▶",
            command=self.toggle_countdown,
            **button_style
        )
        self.start_button.pack(side='left', padx=5)
        
        # Reset button
        tk.Button(
            button_frame,
            text="↺",
            command=self.reset_countdown,
            **button_style
        ).pack(side='left', padx=5)
        
        # Color toggle
        tk.Button(
            button_frame,
            text="🎨",
            command=self.change_color,
            **button_style
        ).pack(side='left', padx=5)
        
        # Fullscreen toggle
        self.fullscreen_btn = tk.Button(
            button_frame,
            text="⛶",
            command=self.toggle_fullscreen,
            **button_style
        )
        self.fullscreen_btn.pack(side='left', padx=5)
    
    def create_display(self):
        self.time_label = tk.Label(
            self.display_frame,
            text="00:00",
            font=("Helvetica", 200, "bold"),
            bg='black',
            fg=self.colors[0]
        )
        self.time_label.pack(expand=True)
    
    def bind_events(self):
        self.root.bind("<F11>", self.toggle_fullscreen)
        self.root.bind("<Escape>", self.exit_fullscreen)
        self.root.bind("<space>", lambda e: self.toggle_countdown())
        self.root.bind("r", lambda e: self.reset_countdown())
        self.root.bind("c", lambda e: self.change_color())
        self.root.bind("<Configure>", self.adjust_font_size)
    
    def toggle_fullscreen(self, event=None):
        if not self.is_fullscreen:
            self.control_frame.pack_forget()
            self.root.attributes('-fullscreen', True)
            self.is_fullscreen = True
        else:
            self.exit_fullscreen()
    
    def exit_fullscreen(self, event=None):
        if self.is_fullscreen:
            self.root.attributes('-fullscreen', False)
            self.control_frame.pack(fill='x', pady=10, before=self.display_frame)
            self.is_fullscreen = False
    
    def adjust_font_size(self, event=None):
        if not self.root.winfo_exists():
            return
        
        width = self.root.winfo_width()
        height = self.root.winfo_height()
        if not self.is_fullscreen:
            height -= 80  # Account for controls
        
        font_size = min(int(width * 0.45), int(height * 0.45))
        self.time_label.configure(font=("Helvetica", font_size, "bold"))
    
    def change_color(self, event=None):
        self.color_index = (self.color_index + 1) % len(self.colors)
        self.time_label.configure(fg=self.colors[self.color_index])
    
    def get_time_input(self):
        try:
            minutes = max(0, min(99, int(self.minutes_var.get())))
            seconds = max(0, min(59, int(self.seconds_var.get())))
            return minutes * 60 + seconds
        except ValueError:
            return 0
    
    def update_display(self):
        minutes = self.time_left // 60
        seconds = self.time_left % 60
        self.time_label.configure(text=f"{minutes:02d}:{seconds:02d}")
        self.minutes_var.set(f"{minutes:02d}")
        self.seconds_var.set(f"{seconds:02d}")
    
    def toggle_countdown(self, event=None):
        if not self.is_running:
            if self.time_left == 0:
                self.time_left = self.get_time_input()
            if self.time_left > 0:
                self.is_running = True
                self.start_button.configure(text="⏸")
                self.countdown()
        else:
            self.is_running = False
            self.start_button.configure(text="▶")
    
    def reset_countdown(self, event=None):
        self.is_running = False
        self.time_left = 0
        self.start_button.configure(text="▶")
        self.update_display()
    
    def countdown(self):
        if self.is_running and self.time_left > 0:
            self.time_left -= 1
            self.update_display()
            self.root.after(1000, self.countdown)
        elif self.time_left == 0 and self.is_running:
            self.is_running = False
            self.start_button.configure(text="▶")
            self.play_finish_sound()
            self.flash_display()
    
    def play_finish_sound(self):
        generate_beep()
    
    def flash_display(self):
        if not self.root.winfo_exists():
            return
        
        current_color = self.time_label.cget("fg")
        self.time_label.configure(fg="#ff0000")
        self.root.after(500, lambda: self.time_label.configure(fg=current_color))
    
    def run(self):
        self.root.mainloop()

def main():
    app = MetopiTimer()
    app.run()

if __name__ == "__main__":
    main()
