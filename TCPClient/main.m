//
//  main.m
//  TCPClient
//
//  Created by Matthew Lintlop on 12/3/17.
//  Copyright © 2017 Matthew Lintlop. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <sys/socket.h>
#include <stdio.h>
#include <stdlib.h>
#include <netdb.h>
#include <netinet/in.h>
#include <string.h>


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        int sockfd, newsockfd, portno;
        socklen_t clilen;
        char buffer[256];
        struct sockaddr_in serv_addr,cli_addr;
        struct hostent *server;
        int n;
        
        if (argc < 3) {
            fprintf(stderr, "usage %s hostname port\n", argv[0]);
            exit(0);
        }
        portno = atoi(argv[2]);
     }
    return 0;
}
