import numpy as np
import cv2
import serial


arduino=serial.Serial("/dev/tty.usbmodem1411",9600) #change port no
if not arduino.is_open:
    arduino.open()


# select haar cascade for feature detection
face_cascade = cv2.CascadeClassifier('haarcascade_frontalface_alt.xml')
side_face = cv2.CascadeClassifier('haarcascade_profileface.xml')

# open default camera
cap = cv2.VideoCapture(0)

# do forever
while 1:
    ret, img = cap.read()
    height, width, channels = img.shape
    img = cv2.resize(img,(width/3,height/3))
    gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
    faces = face_cascade.detectMultiScale(gray, 1.3, 5)
    # profiles = side_face.detectMultiScale(gray,1.3,5)

    im_center = (width/6,height/6)
    # draw recatangles around faces
    for (x,y,w,h) in faces:
        cv2.rectangle(img,(x,y),(x+w,y+h),(255,0,0),2)
        face_center = (x+(w/2),y+(h/2))
        cv2.circle(img,face_center,2,(0,0,255),2)
        cv2.circle(img,im_center,2,(0,255,0),2)

        # defining left and right moves
        left_right_m = 0
        up_down_m = 0

        if im_center[0] - face_center[0]<-30 or im_center[0] - face_center[0]>30:
            cv2.line(img,face_center,im_center,(0,255,0))
            left_right_m = im_center[0] - face_center[0]
            # arduino control code goes here
        if im_center[1] - face_center[1]<-30 or im_center[1] - face_center[1]>30:
            cv2.line(img,face_center,im_center,(0,255,0))
            up_down_m = im_center[1] - face_center[1]

        # up_down_m = up_down_m/40
        if(up_down_m < -20):
            print 'd'
            arduino.write('d')
        elif up_down_m > 20:
            print 'u'
            arduino.write('u')
        # arduino.write(left_right_m)
            # arduino control code goes here

    # code for profile face detection:
    # for (x,y,w,h) in profiles:
    #     print "profile face found"
    #     cv2.rectangle(img,(x,y),(x+w,y+h),(255,0,0),2)
    #     face_center = (x+(w/2),y+(h/2))
    #     cv2.circle(img,face_center,2,(0,0,255),2)
    #     cv2.circle(img,im_center,2,(0,255,0),2)

    #     if im_center[0] - face_center[0]<-30 or im_center[0] - face_center[0]>30:
    #         cv2.line(img,face_center,im_center,(0,255,0))
    #         print "move sevro left/right "+ str(im_center[0] - face_center[0])
    #         # arduino control code goes here
    #     if im_center[1] - face_center[1]<-30 or im_center[1] - face_center[1]>30:
    #         cv2.line(img,face_center,im_center,(0,255,0))
    #         print "move servo up/down" + str(im_center[1] - face_center[1])
    #         # arduino control code goes here


    cv2.imshow('img',img)
    k = cv2.waitKey(30) & 0xff
    if k == 27:
        break

# end video cap and cv2 when done
cap.release()
cv2.destroyAllWindows()