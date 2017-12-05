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
        ssize_t n;
        
        if (argc < 3) {
            fprintf(stderr, "usage %s hostname port\n", argv[0]);
            exit(0);
        }
        portno = atoi(argv[2]);
        
        // Create a socket point
        sockfd = socket(AF_INET, SOCK_STREAM, 0);
        if (sockfd < 0) {
            perror("ERROR opening socket");
            exit(1);
        }
        server = gethostbyname(argv[1]);
        if (server == NULL) {
            fprintf(stderr, "ERROR, no such host: %s\n", argv[1]);
            exit(0);
        }
        printf("Resolved Host: %s\n", server->h_name);
        
        bzero((char*) &serv_addr, sizeof(serv_addr));
        serv_addr.sin_family = AF_INET;
        bcopy((char*)server->h_addr_list[0], (char*)&serv_addr.sin_addr.s_addr, server->h_length);
        serv_addr.sin_port = htons(portno);
        
        // Now connect to the TCP Server
        if (connect(sockfd, (struct sockaddr*)&serv_addr, sizeof(serv_addr)) < 0) {
            perror("ERROR connecting");
            exit(0);
        }
        
        // Now Ask for a message from the user. This message will be read by server.
        printf("Please enter the message to send to the server:");
        bzero(buffer, 256);
        fgets(buffer, 2555, stdin);
        
        // Send the message to the TCP server.
        n = write(sockfd, buffer, strlen(buffer));
        if (n < 0) {
            perror("ERROR writing to socket");
            exit(0);
        }
        
        // Now read the server response
        bzero(buffer, 256);
        n = read(sockfd, buffer, 255);
        if (n < 0) {
            perror("ERROR reading from socket");
            exit(0);
        }
        printf("%s\n", buffer);

        
     }
    return 0;
}
