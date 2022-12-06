#include <stdio.h>
#include <stdlib.h>
#include <sys/stat.h>
#include <stdbool.h>
#include <string.h>

#include "hangman.h"

int get_word(char secret[]){
    // check if file exists first and is readable
    FILE *fp = fopen(WORDLIST_FILENAME, "rb");
    if( fp == NULL ){
        fprintf(stderr, "No such file or directory: %s\n", WORDLIST_FILENAME);
        return 1;
    }

    // get the filesize first
    struct stat st;
    stat(WORDLIST_FILENAME, &st);
    long int size = st.st_size;

    do{
        // generate random number between 0 and filesize
        long int random = (rand() % size) + 1;
        // seek to the random position of file
        fseek(fp, random, SEEK_SET);
        // get next word in row ;)
        int result = fscanf(fp, "%*s %20s", secret);
        if( result != EOF )
            break;
    }while(1);

    fclose(fp);

    return 0;
}

int is_word_guessed(const char secret[], const char letters_guessed[]){
    for(int i = 0; i < strlen(secret); i++){

        bool see_letter = false;

        for(int k = 0; k < strlen(letters_guessed); k++){
            if(secret[i] == letters_guessed[k]){
                see_letter = true;
                break;
            }
        }
        if(see_letter == false){
            return 0;
        }
    }
    return 1;
}


void get_guessed_word(const char secret[], const char letters_guessed[], char guessed_word[]){
    int i = 0;
    for(; i < strlen(secret); i++){

        bool see_letter = false;

        for(int k = 0; k < strlen(letters_guessed); k++){
            if(secret[i] == letters_guessed[k]){
                guessed_word[i] = secret[i];
                see_letter = true;
                break;
            }
        }

        if(see_letter == false){
            guessed_word[i] = '_';
        }
    }

    guessed_word[i] = '\0';
}

void get_available_letters(const char letters_guessed[], char available_letters[]){
    int words = 0;

    for (int i = 0; i < 26; i++){

        char f = 97 + i;
        bool see_letter = false;

        for(int m = 0; m < strlen(letters_guessed); m++){
            if(f == letters_guessed[m]){
                see_letter = true;
                break;
            }
        }

        if(see_letter == false){
            available_letters[words] = f;
            words++;
        }
    }

   available_letters[words] = '\0';
}

bool is_it_letter(char letter) {
    return (letter >= 65 && letter <= 90) || (letter >= 97 && letter <= 122);
}

char to_lowercase(char letter) {
    if (letter >= 65 && letter <=90) {
        return letter + 32;
    }
    return letter;
}

void to_lowercase_array(char letter[]) {
    for(int i = 0; i < strlen(letter); i++) {
        letter[i] = to_lowercase(letter[i]);
    }
}

bool does_secret_contain_letter(const char secret[], const char letter) {
    for(int i = 0; i < strlen(secret); i++) {
        if (secret[i] == letter) {
            return true;
        }
    }

    return false;
}

void hangman(const char secret[]){
    int attepmts = 8;
    int total_letters = 26;
    bool won = false;
    char available_letters[total_letters];
    char guessed_letters[total_letters];
    guessed_letters[0] = '\0';

    printf("\nWelcome to the game, Hangman!");
    printf("\nI am thinking of a word that is %lu letters long.", strlen(secret));
    printf("\n-------------");

    while(attepmts > 0) {
        char letter_string[15];
        get_available_letters(guessed_letters, available_letters);

        printf("\nYou have %d guesses left.", attepmts);
        printf("\nAvailable letters: %s", available_letters);
        printf("\nPlease guess a letter: ");

        scanf("%s", letter_string);

        if (strlen(letter_string) > 1) {
            to_lowercase_array(letter_string);
            if (is_word_guessed(secret, letter_string) == 0) {
                printf("Sorry, bad guess. The word was %s", secret);
            } else {
                won = true;
                printf("-------------");
            }
            break;
        }

        char letter = letter_string[0];
        if (!is_it_letter(letter)) {
            printf("\nOops! %s is not a valid letter: ", letter);
            continue;
        } else {
            letter = to_lowercase(letter);
            guessed_letters[strlen(guessed_letters)] = letter;

            if (is_word_guessed(secret, guessed_letters) == 0) {
                char guessed_word[total_letters];
                get_guessed_word(secret, guessed_letters, guessed_word);

                if (does_secret_contain_letter(secret, letter)) {
                    printf("Good guess: %s", guessed_word);
                } else {
                    printf("Oops! That letter is not in my word: %s", guessed_word);
                    attepmts -= 1;
                }
                printf("\n-------------");
            } else {
                won = true;
                printf("-------------");
                break;
            }
        }
    }

    if (attepmts == 0) {
        printf("\nSorry, you ran out of guesses. The word was %s", secret);
    } else if (won) {
        printf("\nCongratulations, you won!");
    }
}
