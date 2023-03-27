from django.shortcuts import render
import pyrebase
from operator import length_hint
import asyncio
from bleak import BleakClient
from bleak import BleakScanner
from flask import Flask
import os

config = {
    'apiKey': "AIzaSyDvyzt5f80rf_ChMMVx6FK-tmq-G4_jNyo",
    'authDomain': "alphaprototy.firebaseapp.com",
    'databaseURL': "https://alphaprototy-default-rtdb.firebaseio.com",
    'projectId': "alphaprototy",
    'storageBucket': "alphaprototy.appspot.com",
    'messagingSenderId': "535865020467",
    'appId': "1:535865020467:web:031beb4a79df26e87a1346",
    'measurementId': "G-6P01DGDZZ6"
}
firebase = pyrebase.initialize_app(config)
storage = firebase.storage()
db = firebase.database()
app = Flask(__name__)


RED_LED_UUID = '13012F01-F8C3-4F4A-A8F4-15CD926DA146'
GREEN_LED_UUID = '13012F02-F8C3-4F4A-A8F4-15CD926DA146'
BLUE_LED_UUID = '13012F03-F8C3-4F4A-A8F4-15CD926DA146'
write_characteristic = "00002A3D-0000-1000-8000-00805f9b34fb"
read_characteristic = "00002A58-0000-1000-8000-00805f9b34fb"

@app.route('/')
def test(request):
    print ('Start Measuring')
    on_value = bytearray([0x01])
    off_value = bytearray([0x00])

    async def run(request):

        print('ProtoStax Arduino Nano BLE LED Peripheral Central Service')
        print('Looking for Arduino Nano 33 BLE Sense Peripheral Device...')

        found = False
        devices = await BleakScanner.discover()
        for d in devices:    
            if "3A75C1DA-C964-49FC-9297-6AE51DB796A7" == str(d.address): #use MAC address if needed
            #if "1E879941-13B5-44E9-9D50-B34F3B743C82" == str(d.address): #use MAC address if needed
                print('Found Arduino Nano 33 BLE Sense Peripheral')
                found = True
                async with BleakClient(d.address) as client:
                    print(f'Connected to {d.address}')
    
                    input_str = ("test")
                    bytes_to_send = bytearray(map(ord, input_str))
                    await client.write_gatt_char(write_characteristic, bytes_to_send)
                    print(f"Sent: {input_str}")

                    val = await client.read_gatt_char(read_characteristic)
                    val_ = int.from_bytes(val,"big")
                    
                    #val_ = val.hex()
                    #val_ = val_.decode("hex")
                    print (type(val))
                    print (val)
                    print (type(val_))
                    print (val_)
                    db.child('omargrant').update({"Glucose":val_})
                    print ('Value:', val_)

        if not found:
            print('Could not find Arduino Nano 33 BLE Sense Peripheral')

    loop = asyncio.new_event_loop()
    asyncio.set_event_loop(loop)    
    try:
        loop.run_until_complete(run(request))
    except KeyboardInterrupt:
        print('\nReceived Keyboard Interrupt')
    finally:
        print('Program finished') 
        
    return render(request, 'capstone_backendApp.html')

def test2(request):
    return render(request,'capstone_backendApp.html')

""" if __name__ == "__main__":
    app.run(debug=True,host='0.0.0.0',port=int(os.environ.get('PORT', 8080))) """