#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>

#include "hangman.h"

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
    for(; i <strlen(secret); i++){

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
    guessed_word[++i] = '\0';
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

void hangman(const char secret[]){
    int attepmts = 8;
    int total_letters = 26;
    char available_letters[total_letters];
    char guessed_letters[total_letters];

    printf("\nWelcome to the game, Hangman!");
    printf("\nI am thinking of a word that is %lu letters long.", strlen(secret));

    get_available_letters("", available_letters);

    while(attepmts > 0) {
        char letter;

        printf("\n-------------");
        printf("\nYou have %d guesses left.", attepmts);
        printf("\nAvailable letters: %s", available_letters);
        printf("\nPlease guess a letter:");

        scanf("");
        scanf("%c", &letter);
        if (!is_it_letter(letter)) {
            printf("\nOops! %c is not a valid letter: ", letter);
            continue;
        } else {
            attepmts -= 1;
        }
    }   
}

int main(void)
{
    hangman("hello");

    // char letters[2] = {'a', 'c'};
    // char result[30];

    // get_available_letters(letters, result);
   // get_guessed_word("hello","eo",result);

    // printf("\n");
    // for (int i = 0; i < strlen(result); i++)
    // {
    //     printf("\n %c", result[i]);
    // }
}

