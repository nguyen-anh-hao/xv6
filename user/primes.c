/**
 * @file primes.c
 * @brief An implementation of the Sieve of Eratosthenes using pipes and processes in xv6.
 *
 * This program demonstrates the use of inter-process communication (IPC) via pipes to implement
 * the Sieve of Eratosthenes algorithm for finding prime numbers. The main process generates numbers
 * from 2 to 35 and sends them through a pipe to a child process. The child process filters out
 * non-prime numbers and prints the prime numbers.
 *
 * The sieve function reads a prime number from the pipe, prints it, and then creates a new pipe
 * and child process to filter out multiples of the prime number. This process continues recursively
 * until all numbers have been processed.
 *
 * @param pipe_fd The file descriptors for the pipe used for IPC.
 */

#include "kernel/stat.h"
#include "kernel/types.h"
#include "user/user.h"

// Function to perform the sieve of Eratosthenes using pipes
void sieve(int pipe_fd[2]) {
    int prime;
    int number;
    close(pipe_fd[1]);  // Close the write end of the pipe

    // Read the first number from the pipe, which is a prime number
    if (read(pipe_fd[0], &prime, sizeof(prime)) == 0) {
        close(pipe_fd[0]);  // Close the read end of the pipe if no data is read
        return;
    }
    printf("prime %d\n", prime);  // Print the prime number

    int new_pipe_fd[2];
    pipe(new_pipe_fd);  // Create a new pipe

    if (fork() == 0) {       // Create a new child process
        close(pipe_fd[0]);   // Close the read end of the old pipe in the child process
        sieve(new_pipe_fd);  // Recursively call sieve with the new pipe
    } else {
        close(new_pipe_fd[0]);  // Close the read end of the new pipe in the parent process
        // Read numbers from the old pipe and filter out multiples of the prime number
        while (read(pipe_fd[0], &number, sizeof(number)) != 0) {
            if (number % prime != 0) {
                write(new_pipe_fd[1], &number, sizeof(number));  // Write non-multiples to the new pipe
            }
        }
        close(pipe_fd[0]);      // Close the read end of the old pipe
        close(new_pipe_fd[1]);  // Close the write end of the new pipe
        wait(0);                // Wait for the child process to finish
    }
}

int main(int argc, char *argv[]) {
    int initial_pipe_fd[2];
    pipe(initial_pipe_fd);  // Create the initial pipe

    if (fork() == 0) {           // Create the first child process
        sieve(initial_pipe_fd);  // Start the sieve process
    } else {
        close(initial_pipe_fd[0]);  // Close the read end of the initial pipe in the parent process
        // Write numbers from 2 to 35 to the initial pipe
        for (int i = 2; i <= 280; i++) {
            write(initial_pipe_fd[1], &i, sizeof(i));
        }
        close(initial_pipe_fd[1]);  // Close the write end of the initial pipe
        wait(0);                    // Wait for the child process to finish
    }
}