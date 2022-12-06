//important because of usleep()
#define _DEFAULT_SOURCE

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <curses.h>
#include <time.h>
#include <unistd.h>

void roll_text();
void draw_logo();
void screensaver();
void moving_arrow();

int main(){
  srand(time(NULL));
  int selection = 0;

  do{
    printf("\nPress 1 to start Rolling Text.\nPress 2 to start Drawing Logo.");
    printf("\nPress 3 to start Screensaver.\nPress 4 to start Moving Arrow.");
    printf("\nPress 5 to Exit.\n\n");

   do{
        printf("Your selection: ");
        scanf("%d", &selection);
    } while(selection < 1 || selection > 5);

    if(selection == 5){
        continue;
    }

    //initialize the library
    initscr();
    //set implicit modes
    cbreak();
    noecho();
    keypad(stdscr,TRUE);
    // invisible cursor, visibility of cursor (0,1,2)
    curs_set(FALSE);
    //getch() will be non-blocking
    nodelay(stdscr, TRUE);

    switch(selection){
        case 1:  roll_text(); break;
        case 2:  draw_logo(); break;
        case 3:  screensaver(); break;
        default: moving_arrow(); break;
    }

    //end curses
    endwin();
  } while (selection != 5);

  printf("Bye!\n");

  return 0;
}

void roll_text(){
    clear();
    char buffer[COLS];

    char text[] = ".....Sokoban (warehouse keeper) is a type of transport puzzle, in which the player pushes boxes or crates around in a warehouse, trying to get them to storage locations. The puzzle is usually implemented as a video game.";
    int y = LINES-1;

    for( int offset = 0; offset < strlen(text); offset++ ){
        strncpy(buffer, text + offset, COLS);

        move(y,0);
        printw( "%s", buffer );
        refresh();
        usleep( 1 * 100000 );
    }
}

void draw_logo(){
    clear();
    char logo[5][44] = {
        {"                                           "},
        {" _____ _____ _____ _____ _____ _____ _____ "},
        {"|   __|     |  |  |     | __  |  _  |   | |"},
        {"|__   |  |  |    -|  |  | __ -|     | | | |"},
        {"|_____|_____|__|__|_____|_____|__|__|_|___|"}
    };

    int center = COLS/2 - strlen(logo[0])/2;

    int target = 15;
    for( int row_count = 4; row_count >= 1; row_count-- ){

        for( int y = 1; y <= target; y++ ){
            move(y, center);
            printw("%s", logo[row_count]);
            refresh();
            usleep( 1 * 100000 );

            // clear
            move(y,center);
            printw(logo[0]);
        }

        move(target,center);
        printw(logo[row_count]);

        target--;
    }
    usleep( 2 * 1000000 );
}

void screensaver(){
    int y = 1;
    int x = 1;
    int dx = 1, dy = 1;
    char message[] = "hello world from curses";

    int moves = 150;
    while( moves > 0 ){
        clear();
        move(y,x);
        printw("%s", message);
        refresh();
        usleep( 1 * 100000 );

        // update
        if( y == LINES - 1 || y == 0)
            dy *= -1;
        if( x == COLS - strlen(message) || x == 0 )
            dx *= -1;

        y += dy;
        x += dx;
        moves -= 1;
    }
}

void moving_arrow(){
    clear();
    int y = LINES / 2;
    int x = COLS / 2;
    char buffer[] = "Press q/Q to quit. Move by arrows.";
    mvprintw(LINES - 1, 0, "%s", buffer);
    char player = '>', previous = ' ';
    mvprintw(y, x, "%c", player);
    refresh();
    int c;
    do{
        c = getch();
        previous = (y == LINES - 1 && x < 34) ? buffer[x] : ' ';
        if(c == KEY_LEFT || c == KEY_RIGHT || c == KEY_UP || c == KEY_DOWN){
            mvprintw(y, x, "%c", previous);
        }
        switch(c){
            case KEY_LEFT: player = '<';
                           x = (x > 0) ? x - 1 : COLS - 1;
                           break;
            case KEY_RIGHT: player = '>';
                            x = (x < COLS - 1) ? x + 1 : 0;
                            break;
            case KEY_UP: player = '^';
                         y = (y > 0) ? y - 1 : LINES - 1;
                         break;
            case KEY_DOWN: player = 'v';
                           y = (y < LINES - 1) ? y + 1 : 0;
                           break;
            default: continue; break;
        }
        mvprintw(y, x, "%c", player);
        refresh();
    } while(c != 'q' && c != 'Q');
}