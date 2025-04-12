import time
from flask_socketio import SocketIO
from flask import Flask
import pyautogui


app=Flask(__name__)
socketio=SocketIO(app,cors_allowed_origins="*")


# mouse speed setting
MOUSE_SPEED = 2 

# last move time
last_move_time = time.time()

# Minimum time between movements (in seconds)
MIN_MOVE_INTERVAL = 0.01  # 10 milliseconds


@socketio.on('mouse_move')
def handle_mouse_move(data):
    global last_move_time
    current_time = time.time()
    
    # Check the time elapsed since the last movement
    if current_time - last_move_time < MIN_MOVE_INTERVAL:
        return  # Ignore very repetitive movements.
        
    dx = data.get('dx', 0)
    dy = data.get('dy', 0)
    
    if abs(dx) < 0.1 and abs(dy) < 0.1:
        return  # Ignore very small movements
    
    # Speed ​​coefficient application
    dx = dx * MOUSE_SPEED
    dy = dy * MOUSE_SPEED
    
    # mouse move
    pyautogui.move(dx, dy)
    print(f"Mouse Move: dx={dx}, dy={dy}")
    
    # Update last movement time    
    last_move_time = current_time


@socketio.on('mouse_command')
def handle_mouse_command(command):
    print(f"Order received: {command}")
    
    if command == "click":
        pyautogui.click()
    if command == "right_click":
        pyautogui.rightClick()


@socketio.on('mouse_stop')
def handle_mouse_stop():
    print("🛑 Mouse Stop")


if __name__=="__main__":
    print("Starting Mouse Server...")
    socketio.run(app,host="0.0.0.0",port=5000)