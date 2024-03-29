CC	=	gcc
LD	=	gcc
libDirs =	-lssl -lcrypto -lpam
incDirs =	-I /usr/include/openssl -I /usr/include/krb5
LDFLAGS =	
PAM_LDFLAGS = ${LDFLAGS} -shared
LIBS	=
CPFLAGS	=	-O2 -fPIC -g -Wall

SRCS	=\
	pam_cas.c\
	cas_validator.c\
	xml.c\
	read_config.c

OBJS 	=\
	pam_cas.o\
	cas_validator.o\
	xml.o\
	read_config.o

SRCTEST =\
	castest.c

OBJTEST =castest.o

BINTEST	=castest

PAM_CAS  =pam_cas.so

#------------------ targets -------------

all:	$(PAM_CAS)

objs	:$(OBJS)

cleanobjs:
	rm -f $(OBJS)

cleanbin:
	rm -f $(PAM_CAS)

test:	$(BINTEST)

cleantest:
	rm -f $(OBJTEST) $(BINTEST)

clean:	cleanobjs cleanbin cleantest

#--------------- Dependency rules --------

pam_cas.so:	$(OBJS)
	$(LD) -o pam_cas.so $(OBJS) $(libDirs) $(PAM_LDFLAGS) $(LIBS)

pam_cas.o:	pam_cas.c cas.h
	$(CC) $(CPFLAGS) $(incDirs) -c -o $@ $<

xml.o:		xml.c xml.h
	$(CC) $(CPFLAGS) $(incDirs) -c -o $@ $<

cas_validator.o: cas_validator.c cas.h xml.h
	$(CC) $(CPFLAGS) $(incDirs) -c -o $@ $<

read_config.o:	read_config.c cas.h
	$(CC) $(CPFLAGS) $(incDirs) -c -o $@ $<

#--------------- Dependency for tests  --------

castest: castest.o $(OBJS)
	$(LD) -o castest castest.o $(OBJS) $(incDirs) $(libDirs) $(LDFLAGS) $(LIBS)

castest.o: castest.c cas.h
	$(CC) $(CPFLAGS) $(incDirs) -c -o $@ $<
