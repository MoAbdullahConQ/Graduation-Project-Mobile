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




if __name__=="__main__":
    print("Starting Mouse Server...")
    socketio.run(app,host="0.0.0.0",port=5000)