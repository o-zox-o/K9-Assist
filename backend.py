# backend.py

from flask import Flask, request, jsonify
from ultralytics import YOLO
import os
import cv2

app = Flask(__name__)
model = YOLO("yolov8n-pose.pt")  # Change to your dog-pose model

@app.route("/analyze", methods=["POST"])
def analyze_video():
    video = request.files['video']
    video_path = "uploaded_video.mp4"
    video.save(video_path)

    cap = cv2.VideoCapture(video_path)
    pass_count = 0
    total_frames = 0

    while cap.isOpened():
        ret, frame = cap.read()
        if not ret:
            break
        total_frames += 1
        results = model(frame)
        keypoints = results[0].keypoints
        if keypoints is not None:
            pass_count += 1

    cap.release()
    os.remove(video_path)

    pass_ratio = pass_count / total_frames if total_frames > 0 else 0
    result = "Passed ✅" if pass_ratio > 0.5 else "Fail ❌"
    return jsonify({"result": result})

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
