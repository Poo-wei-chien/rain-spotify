# syntax=docker/dockerfile:1

FROM python:3.10.0

WORKDIR /api

COPY requirements.txt requirements.txt
RUN pip3 install -r requirements.txt --no-cache-dir \
    && pip3 uninstall urllib3 -y --cert root.pem \
    && pip3 install --no-cache-dir -U urllib3 --cert root.pem

COPY api/ .

CMD ["gunicorn", "--workers=1", "--bind", "0.0.0.0:5000", "spotify:app"]
