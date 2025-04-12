from flask_socketio import SocketIO
from flask import Flask
import pyautogui


app=Flask(__name__)
socketio=SocketIO(app,cors_allowed_origins="*")



if __name__=="__main__":
    print("Starting Mouse Server...")
    socketio.run(app,host="0.0.0.0",port=5000)