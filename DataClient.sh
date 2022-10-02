#!</usr/bin/python3>
#Link to the python interpreter when executing as bashscript on the Linux Container

#imports for influxdb
import influxdb_client
from influxdb_client.client.write_api import SYNCHRONOUS
#Imports for speedtest
import speedtest
servers = []

bucket = "15dcaded7cb11a82"
org = "f3c403cbbf09a8f7"
token = "5eVs34jNv5IvTPXv4sqW9a1LKAI_KH1TRDaFe5kPq6SVl9P4_UOqX6gYJr0_6VXWKzdTmlnzvSMNIm32tMDSMg=="
# Store the URL of your InfluxDB instance
url = "http://192.168.178.52:8086/"

client = influxdb_client.InfluxDBClient(
    url=url,
    token=token,
    org=org
)


threads = None
#speedtest.Speedtest
#speedtest.Speedtest.

#Measure Data:
speed_test = speedtest.Speedtest(secure=True)

def bytes_to_mb(bytes):
  KB = 1024 # One Kilobyte is 1024 bytes
  MB = KB * 1024 # One MB is 1024 KB
  return int(bytes/MB)


#sprint(servers[0])
speed_test._secure = True
speed_test.get_servers(servers)
speed_test.get_best_server()
download_speed =  speed_test.download(threads = threads)
print("Your Download speed is", bytes_to_mb(download_speed), 'MByte/S') 
upload_speed = speed_test.upload(threads = threads)
print("Your Upload speed is", bytes_to_mb(upload_speed), 'MByte/S')

#send data to database
write_api = client.write_api(write_options=SYNCHRONOUS)

u = influxdb_client.Point("Download").field("Download", bytes_to_mb(download_speed))
write_api.write(bucket=bucket, org=org, record=u)

d = influxdb_client.Point("Upload").field("Upload", bytes_to_mb(upload_speed))
write_api.write(bucket=bucket, org=org, record=d)
