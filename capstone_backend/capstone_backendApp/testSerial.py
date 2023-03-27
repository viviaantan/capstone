import asyncio
from bleak import BleakClient
from bleak import BleakScanner
import views

RED_LED_UUID = '13012F01-F8C3-4F4A-A8F4-15CD926DA146'
GREEN_LED_UUID = '13012F02-F8C3-4F4A-A8F4-15CD926DA146'
BLUE_LED_UUID = '13012F03-F8C3-4F4A-A8F4-15CD926DA146'
write_characteristic = "00002A3D-0000-1000-8000-00805f9b34fb"
read_characteristic = "00002A58-0000-1000-8000-00805f9b34fb"

on_value = bytearray([0x01])
off_value = bytearray([0x00])

async def run():

    print('ProtoStax Arduino Nano BLE LED Peripheral Central Service')
    print('Looking for Arduino Nano 33 BLE Sense Peripheral Device...')

    found = False
    devices = await BleakScanner.discover()
    for d in devices:    
        if "3A75C1DA-C964-49FC-9297-6AE51DB796A7" == str(d.address): #use MAC address if needed
            print('Found Arduino Nano 33 BLE Sense Peripheral')
            found = True
            async with BleakClient(d.address) as client:
                print(f'Connected to {d.address}')

                while True:
                    input_str = ("test")
                    bytes_to_send = bytearray(map(ord, input_str))
                    await client.write_gatt_char(write_characteristic, bytes_to_send)
                    print(f"Sent: {input_str}")

                    val = await client.read_gatt_char(read_characteristic)
                    val_ = int.from_bytes(val,"big")
                    print (val_)

            

    if not found:
        print('Could not find Arduino Nano 33 BLE Sense Peripheral')
         
loop = asyncio.get_event_loop()
try:
    loop.run_until_complete(run())
except KeyboardInterrupt:
    print('\nReceived Keyboard Interrupt')
finally:
    print('Program finished')
        