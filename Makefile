CC            = g++
CFLAGS        = -DRASPBERRY_PI -DBCM2835_NO_DELAY_COMPATIBILITY -fPIC
LIBS          = -lbcm2835
RADIOHEADBASE = ./src
INCLUDE       = -I$(RADIOHEADBASE)

all: libradiohead.so

libradiohead.so: RH_RF24.o  RHMesh.o RHRouter.o RHReliableDatagram.o RHDatagram.o RasPi.o RHHardwareSPI.o RHNRFSPIDriver.o RHGenericDriver.o RHGenericSPI.o adapter.o
	$(CC) $(CFLAGS) -shared -o libradiohead.so *.o -lbcm2835
	rm *.o

adapter.o: $(RADIOHEADBASE)/adapter.cpp
	$(CC) $(CFLAGS) -c $(RADIOHEADBASE)/adapter.cpp $(INCLUDE)

RasPi.o: $(RADIOHEADBASE)/RHutil/RasPi.cpp
	$(CC) $(CFLAGS) -c $(RADIOHEADBASE)/RHutil/RasPi.cpp $(INCLUDE)

RH_RF24.o: $(RADIOHEADBASE)/RH_RF24.cpp
	$(CC) $(CFLAGS) -c $(INCLUDE) $<

RHMesh.o: $(RADIOHEADBASE)/RHMesh.cpp
	$(CC) $(CFLAGS) -c $(INCLUDE) $<

RHRouter.o: $(RADIOHEADBASE)/RHRouter.cpp
	$(CC) $(CFLAGS) -c $(INCLUDE) $<

RHReliableDatagram.o: $(RADIOHEADBASE)/RHReliableDatagram.cpp
	$(CC) $(CFLAGS) -c $(INCLUDE) $<

RHDatagram.o: $(RADIOHEADBASE)/RHDatagram.cpp
	$(CC) $(CFLAGS) -c $(INCLUDE) $<

RHHardwareSPI.o: $(RADIOHEADBASE)/RHHardwareSPI.cpp
	$(CC) $(CFLAGS) -c $(INCLUDE) $<

RHNRFSPIDriver.o: $(RADIOHEADBASE)/RHNRFSPIDriver.cpp
	$(CC) $(CFLAGS) -c $(INCLUDE) $<

RHGenericDriver.o: $(RADIOHEADBASE)/RHGenericDriver.cpp
	$(CC) $(CFLAGS) -c $(INCLUDE) $<

RHGenericSPI.o: $(RADIOHEADBASE)/RHGenericSPI.cpp
	$(CC) $(CFLAGS) -c $(INCLUDE) $<

RasPiRH: RasPiRH.o  RH_RF24.o RHMesh.o RHRouter.o RHReliableDatagram.o RHDatagram.o RasPi.o RHHardwareSPI.o RHNRFSPIDriver.o RHGenericDriver.o RHGenericSPI.o
	$(CC) $^ $(LIBS) -o RasPiRH

client_RH: client_RH.o  RH_RF24.o RHMesh.o RHRouter.o RHReliableDatagram.o RHDatagram.o RasPi.o RHHardwareSPI.o RHNRFSPIDriver.o RHGenericDriver.o RHGenericSPI.o
	$(CC) $^ $(LIBS) -o client_RH

clean:
	rm -rf *.o *.so *.pyc

