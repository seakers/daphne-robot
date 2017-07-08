import cv2
import sys
import serial

arduino=serial.Serial("/dev/ttyAMA0",9600)
arduino.isOpen()

cascPath = sys.argv[1]
faceCascade = cv2.CascadeClassifier(cascPath)

video_capture = cv2.VideoCapture(0)

while True:
    # Capture frame-by-frame
    ret, frame = video_capture.read()
    frame = cv2.resize(frame,(140,105))

    gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)

    faces = faceCascade.detectMultiScale(
        gray,
        scaleFactor=1.1,
        minNeighbors=1,
        minSize=(10, 10),
        flags=cv2.cv.CV_HAAR_SCALE_IMAGE
    )

    # Draw a rectangle around the faces
    for (x, y, w, h) in faces:
        cv2.rectangle(frame, (x, y), (x+w, y+h), (0, 255, 0), 2)
        midFaceX = x+(w/2)
        midScreenX = 70
        # Determine where to move the servos according to the position of the face
        if(midFaceX < midScreenX - 15):
            arduino.write('l')
            print "Face on the right, move to the left\n"
        elif(midFaceX > midScreenX + 15):
            arduino.write('r')
            print "Face on the left, move to the right\n"
        else:
            print "Face on the middle, we don't need to move\n"

    #cv2.imwrite("/home/pi/Desktop/im.jpg", frame)

    cv2.imshow('Video', frame)

    if cv2.waitKey(1) & 0xFF == ord('q'):
        break

# When everything is done, release the capture
video_capture.release()
cv2.destroyAllWindows()