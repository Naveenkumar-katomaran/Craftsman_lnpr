FROM python:3.12-slim

# ENV PYTHONUNBUFFERED=1 \
#     OPENCV_FFMPEG_CAPTURE_OPTIONS="rtsp_transport;tcp|fflags;nobuffer|flags;low_delay|analyzeduration;0|probesize;32"

WORKDIR /app

RUN apt-get update && apt-get install -y --no-install-recommends \
        ffmpeg \
        libsm6 \
        libxext6 \
        libgl1 \
        build-essential \
        wget \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

RUN mkdir -p ./lnpr_outputs/cropped_plates ./lnpr_outputs/cropped_vehicles

CMD ["python3", "main.py"]
