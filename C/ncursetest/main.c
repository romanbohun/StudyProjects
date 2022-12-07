#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <stdbool.h>
#include <string.h>
#include <curses.h>

#define BLANK ' '

#define SPACE_KEY 32
#define ENTER_KEY 10

#define s_ball1 '!'
#define s_ball2 '@'
#define s_ball3 '#'
#define s_ball4 '$'
#define s_ball5 '%'
#define s_ball6 '&'
#define s_ball7 '*'

const short c_ball1 = 1;
const short c_ball2 = 2;
const short c_ball3 = 3;
const short c_ball4 = 4;
const short c_ball5 = 5;
const short c_ball6 = 6;
const short c_ball7 = 7;
const short c_box = 8;
const short c_logo = 9;
const short c_selected_ball = 10;
const short c_level_label = 11;
const short c_level_number = 12;
const short c_control_text = 13;
const short c_win_text = 14;
const short c_game_over_text = 15;

int key_pressed = 0;

int window_width, window_height;

int level = 1;
const int max_level = 5;

int field_rows = 0;
int field_columns = 0;

void fill_array_with_random_number(int lower, int upper, int numbers[], int count);
int get_random_number(int lower, int upper);
void generate_balls(int length, char balls[length]);
void ball_sort_puzzle();

void SetupColors();
int get_string_length(const char* str);
int calculate_logo_width();
int calculate_win_width();
int calculate_game_over_width();
void draw_logo(int h, int w);

const char *logo[6] = {
        " _____             _     ____        _ _   _____               _",
        "/ ____|           | |   |  _ \\      | | | |  __ \\             | |",
        "| (___   ___  _ __| |_  | |_) | __ _| | | | |__) |   _ _______| | ___",
        "\\___  \\ / _ \\| '__| __| |  _ < / _` | | | |  ___/ | | |_  /_  / |/ _ \\",
        "\\____) | (_) | |  | |_  | |_) | (_| | | | | |   | |_| |/ / / /| |  __/",
        "|_____/ \\___/|_|   \\__| |____/ \\__,_|_|_| |_|    \\__,_/___/___|_|\\___|"
};

const char *win_message[6] = {
        " ____  ____                              _           ",
        "|_  _||_  _|                            (_)         ",
        "  \\ \\  / / .--.   __   _    _   _   __  __   _ .--.   ",
        "   \\ \\/ // .'`\\ \\[  | | |  [ \\ [ \\ [  ][  | [ `.-. |   ",
        "   _|  |_| \\__. | | \\_/ |,  \\ \\/\\ \\/ /  | |  | | | |   ",
        "  |______|'.__.'  '.__.'_/   \\__/\\__/  [___][___||__] "
};

const char *game_over[6] = {
        " _____                            ____                      ",
        "/ ____|                          / __ \\                     ",
        "| |  __   __ _  _ __ ___    ___  | |  | |__   __ ___  _ __  ",
        "| | |_ | / _` || '_ ` _ \\  / _ \\ | |  | |\\ \\ / // _ \\| '__| ",
        "| |__| || (_| || | | | | ||  __/ | |__| | \\ V /|  __/| |    ",
        "\\_____| \\__,_||_| |_| |_| \\___|  \\____/   \\_/  \\___||_|     "
};

int game_over_height = sizeof(game_over) / sizeof(game_over[0]);
int game_over_width = 1;

int win_message_height = sizeof(win_message) / sizeof(win_message[0]);
int win_message_width = 1;

int logo_height = sizeof(logo) / sizeof(logo[0]);
int logo_width = 1;

char *message[1] = {""};
char *controls_rules[1] = {"Navigation <- -> arrows. SPACE to select and put ball. Q main menu."};

int main() {
    initscr();
    keypad(stdscr, TRUE);
    savetty();
    cbreak();
    noecho();
    timeout(0);
    leaveok(stdscr, TRUE);
    curs_set(0);

    if (!has_colors()) {
        endwin();
        printf("Your terminal does not support color\n");
    }

    typedef enum {
        MENU,
        GAME,
        ABOUT,
        EXIT,
    } game_state;

    game_state current_state;
    current_state = MENU;

    const char *start_game_menu_item[2] = {
            "> START GAME  ",
            "start game",
    };

    const char *about_game_menu_item[2] = {
            "> ABOUT  ",
            "about",
    };

    const char *exit_game_menu_item[2] = {
            "> EXIT  ",
            "exit",
    };

    while (current_state != EXIT) {
        SetupColors();

        getmaxyx(stdscr, window_height, window_width);

        static int menu_item = 0;
        if (key_pressed == KEY_UP)   menu_item--;
        if (key_pressed == KEY_DOWN) menu_item++;

        if (menu_item >= 2) menu_item = 2;
        if (menu_item <= 0) menu_item = 0;

        switch(current_state) {
            case MENU:
                draw_logo(window_height, window_width);

                int select_start_game = menu_item == 0 ? 0 : 1;
                mvprintw(window_height / 2 - logo_height + 9, window_width / 2 -
                                                              get_string_length(start_game_menu_item[select_start_game]) / 2, start_game_menu_item[select_start_game]);

                int select_info = menu_item == 1 ? 0 : 1;
                mvprintw(window_height / 2 - logo_height + 11, window_width / 2 -
                                                               get_string_length(about_game_menu_item[select_info]) / 2, about_game_menu_item[select_info]);

                int select_exit = menu_item == 2 ? 0 : 1;
                mvprintw(window_height / 2 - logo_height + 13, window_width / 2 -
                                                               get_string_length(exit_game_menu_item[select_exit]) / 2, exit_game_menu_item[select_exit]);

                attron(COLOR_PAIR(c_box));
                box(stdscr, 0, 0);
                attron(COLOR_PAIR(c_box));

                if (key_pressed == ENTER_KEY) {
                    switch(menu_item) {
                        case 0:
                            current_state = GAME;
                            break;

                        case 1:
                            current_state = ABOUT;
                            break;

                        case 2:
                            current_state = EXIT;
                            break;
                        default:
                            current_state = MENU;
                            break;
                    }
                }
                break;

            case ABOUT:
                break;

            case GAME:
                ball_sort_puzzle();
                current_state = MENU;
                timeout(0);
                break;

            case EXIT:
                endwin();
                break;
        }

        key_pressed = wgetch(stdscr);
        napms(100);
        key_pressed = wgetch(stdscr);

        erase();
    }

    endwin();

    return 0;
}

void SetupColors() {
    start_color();
    init_pair(c_ball1, COLOR_BLUE, COLOR_BLACK);
    init_pair(c_ball2, COLOR_WHITE, COLOR_BLACK);
    init_pair(c_ball3, COLOR_RED, COLOR_BLACK);
    init_pair(c_ball4, COLOR_GREEN, COLOR_BLACK);
    init_pair(c_ball5, COLOR_MAGENTA, COLOR_BLACK);
    init_pair(c_ball6, COLOR_YELLOW, COLOR_BLACK);
    init_pair(c_ball7, COLOR_CYAN, COLOR_BLACK);
    init_pair(c_box, COLOR_BLUE, COLOR_BLACK);
    init_pair(c_logo, COLOR_GREEN, COLOR_BLACK);
    init_pair(c_selected_ball, COLOR_YELLOW, COLOR_BLACK);

    init_pair(c_level_label, COLOR_BLACK, COLOR_WHITE);
    init_pair(c_level_number, COLOR_RED, COLOR_WHITE);

    init_pair(c_control_text, COLOR_BLUE, COLOR_WHITE);

    init_pair(c_win_text, COLOR_GREEN, COLOR_BLACK);
    init_pair(c_game_over_text, COLOR_RED, COLOR_BLACK);
}

void draw_logo(int h, int w) {
    if (logo_width == 1) {
        logo_width = calculate_logo_width() / 2;
    }

    attron(COLOR_PAIR(c_logo));
    for (int i = 0; i < logo_height; i++) {
        mvprintw(3 + i, w/2 - logo_width, logo[i]);
    }
    attroff(COLOR_PAIR(c_logo));
}

void draw_win_message(int h, int w) {
    if (win_message_width == 1) {
        win_message_width = calculate_win_width() / 2;
    }

    attron(COLOR_PAIR(c_win_text));
    for (int i = 0; i < win_message_height; i++) {
        mvprintw(3 + i, w/2 - win_message_width, win_message[i]);
    }
    attroff(COLOR_PAIR(c_win_text));
}

void draw_game_over(int h, int w) {
    if (game_over_width == 1) {
        game_over_width = calculate_game_over_width() / 2;
    }

    attron(COLOR_PAIR(c_game_over_text));
    for (int i = 0; i < game_over_height; i++) {
        mvprintw(3 + i, w/2 - game_over_width, game_over[i]);
    }
    attroff(COLOR_PAIR(c_game_over_text));
}

void print_message(int y) {
    if (strcmp(message[0], "") != 0) {
        mvprintw(y + field_rows + 1 + (window_height / 5), window_width / 2 - (get_string_length(message[0]) / 2), message[0]);
    }
}

void turn_on_ball_color(int ball) {
    switch (ball) {
        case s_ball1:
            attron(COLOR_PAIR(c_ball1));
            break;
        case s_ball2:
            attron(COLOR_PAIR(c_ball2));
            break;
        case s_ball3:
            attron(COLOR_PAIR(c_ball3));
            break;
        case s_ball4:
            attron(COLOR_PAIR(c_ball4));
            break;
        case s_ball5:
            attron(COLOR_PAIR(c_ball5));
            break;
        case s_ball6:
            attron(COLOR_PAIR(c_ball6));
            break;
        case s_ball7:
            attron(COLOR_PAIR(c_ball7));
            break;
    }
}

void turn_off_ball_color(int ball) {
    switch (ball) {
        case s_ball1:
            attroff(COLOR_PAIR(c_ball1));
            break;
        case s_ball2:
            attroff(COLOR_PAIR(c_ball2));
            break;
        case s_ball3:
            attroff(COLOR_PAIR(c_ball3));
            break;
        case s_ball4:
            attroff(COLOR_PAIR(c_ball4));
            break;
        case s_ball5:
            attroff(COLOR_PAIR(c_ball5));
            break;
        case s_ball6:
            attroff(COLOR_PAIR(c_ball6));
            break;
        case s_ball7:
            attroff(COLOR_PAIR(c_ball7));
            break;
    }
}

/* ****************************************
     Game logic functions and procedures
   **************************************** */
void generator(const int rows, const int columns, char field[rows][columns]){
    int columns_to_ignore[2];
    fill_array_with_random_number(0, columns - 1, columns_to_ignore, 2);

    int balls_length = columns - 2;
    char balls[balls_length];

    generate_balls(balls_length, balls);

    int field_length = rows * (columns - 2);
    char balls_field[field_length];


    for(int k = 0; k < field_length; k++){
        balls_field[k] = BLANK;
    }

    // fill randomly balls in balls_field
    for(int i = 0; i < balls_length; i++){
        int count = rows;
        while(count > 0){
            int cell = get_random_number(0, field_length - 1);
            if (balls_field[cell] == BLANK){
                balls_field[cell] = balls[i];
                count--;
            }
        }
    }

    // fill original field array with balls from balls_field array
    int iColumn = 0;
    int index = 0;
    while(iColumn < columns) {
        for(int i = 0; i < rows; i++){
            if (iColumn == columns_to_ignore[0] || iColumn == columns_to_ignore[1]) {
                field[i][iColumn] = BLANK;
            } else {
                field[i][iColumn] = balls_field[index++];
            }
        }
        iColumn++;
    }
}

void down_possible(const int rows, const int columns, char field[rows][columns], int x, int y){
    if (x == y) {
        return;
    }

    int originX = x - 1;
    int originY = y - 1;

    char ball = BLANK;
    int ballRowIndex = -1;

    // go from top to bottom, looking for a ball
    for(int i = 0; i < rows; i++) {
        if (field[i][originX] != BLANK) {
            ball = field[i][originX];
            ballRowIndex = i;
            break;
        }
    }

    if (ball == BLANK) {
        return;
    }

    // check if there is space in the target column
    //          there is last ball is the same type
    int index = rows - 1;
    char previousBall = '\0';
    bool put = false;
    while(index >= 0) {
        if (field[index][originY] == BLANK && (previousBall == ball || previousBall == '\0')) {
            field[index][originY] = ball;
            field[ballRowIndex][originX] = BLANK;
            put = true;
            break;
        }

        previousBall = field[index][originY];
        index--;
    }

    if (!put){
        message[0] = "Balls must be the same color";
    }
}

bool check(const int rows, const int columns, char field[rows][columns]){
    for(int i = 0; i < columns; i++){
        char firstBall = field[0][i];
        for(int j = 1; j < rows; j++){
            if(firstBall != field[j][i]) {
                return false;
            }
        }
    }
    return true;
}

void game_field(const int rows, const int columns, char field[rows][columns], int xStart, int yStart){
    int x, y = 0;
    y = yStart;

    for(int r = 0; r < rows; r++){
        y += 1;

        x = xStart;
        mvprintw(y, x,"|");

        for(int c = 0; c < columns; c++){
            char ball[1] = {field[r][c]};

            mvprintw(y, ++x, " ");
            turn_on_ball_color(ball[0]);
            mvprintw(y, ++x, ball);
            turn_off_ball_color(ball[0]);
            mvprintw(y, ++x, " ");
            mvprintw(y, ++x, "|");
        }
    }

    x = xStart + 1;
    y += 1;
    for(int c = 0; c < columns; c++){
        mvprintw(y, x, "---");
        x += 4;
    }
}

void clear_message() {
    message[0] = "";
}

void init_field_size() {
    field_columns = field_rows = 5 + level - 1;
}

void ball_sort_puzzle(){
    level = 1;

    init_field_size();

    char field[field_rows][field_columns];
    bool inProgress = true;
    bool won = false;

    generator(field_rows, field_columns, field);

    int what = -1;
    int where = -1;
    int selector = 0;
    int selected_ball_column = -1;
    bool game_finished = false;

    while(inProgress){

        if (key_pressed == KEY_LEFT) {
            selector = selector == 0 ? selector : selector - 1;
            clear_message();
        } else if (key_pressed == KEY_RIGHT) {
            selector = selector == field_columns - 1 ? selector : selector + 1;
            clear_message();
        } else if (key_pressed == SPACE_KEY) {
            if (selected_ball_column == -1) {
                selected_ball_column = selector;
                what = selector + 1;
            } else {
                where = selector + 1;
            }
            clear_message();
        } else if (key_pressed == 'q') {
            level = 1;
            clear_message();
            return;
        }

        getmaxyx(stdscr, window_height, window_width);

        if (won) {
            key_pressed = -1;

            while(key_pressed < 0) {
                getmaxyx(stdscr, window_height, window_width);

                erase();

                draw_win_message(window_height, window_width);

                attron(COLOR_PAIR(c_box));
                box(stdscr, 0, 0);
                attroff(COLOR_PAIR(c_box));

                message[0] = "Press any key";
                print_message(10);

                key_pressed = wgetch(stdscr);
                napms(100);
                key_pressed = wgetch(stdscr);
            }

            clear_message();

            level += 1;

            if (level > max_level) {
                game_finished = true;
                break;
            }

            init_field_size();
            generator(field_rows, field_columns, field);
            won = false;
        } else {
            int xStart = window_width / 2 - ((field_columns * 4) / 2);
            int yStart = window_height / 2 - ((field_rows + 1) / 2);

            int xCursorPosition = xStart + 2;
            int yCursorPosition = yStart - 1;

            attron(COLOR_PAIR(c_level_label));
            for(int i = 1; i < window_width; i++) {
                mvprintw(1, i, " ");
            }
            mvprintw(1, 1, "LEVEL: %c", 48 + level);
            attroff(COLOR_PAIR(c_level_label));

            mvprintw(yCursorPosition, xCursorPosition + (selector * 4), "V");

            game_field(field_rows, field_columns, field, xStart, yStart);

            if (selected_ball_column >= 0) {
                attron(COLOR_PAIR(c_selected_ball));
                mvprintw(yCursorPosition - 1, xCursorPosition + (selector * 4), "?");
                attroff(COLOR_PAIR(c_selected_ball));
            }
            mvprintw(yCursorPosition, xCursorPosition + (selector * 4), "V");

            if (selected_ball_column >= 0) {
                attron(COLOR_PAIR(c_selected_ball));
                mvprintw(yStart, xCursorPosition + (selected_ball_column * 4), "V");
                attroff(COLOR_PAIR(c_selected_ball));
            }

            print_message(yStart);

            attron(COLOR_PAIR(c_control_text));
            for(int i = 1; i < window_width; i++) {
                mvprintw(window_height - 2, i, " ");
            }
            mvprintw(window_height - 2, window_width / 2 - (get_string_length(controls_rules[0]) / 2), controls_rules[0]);
            attroff(COLOR_PAIR(c_control_text));

            attron(COLOR_PAIR(c_box));
            box(stdscr, 0, 0);
            attroff(COLOR_PAIR(c_box));

            if (what >=0 && where >= 0) {
                down_possible(field_rows, field_columns, field, what, where);
                what = -1;
                where = -1;
                selected_ball_column = -1;
            }

            won = check(field_rows, field_columns, field);
        }

        key_pressed = wgetch(stdscr);
        napms(100);
        key_pressed = wgetch(stdscr);

        erase();
    }

    if (game_finished) {

        key_pressed = -1;

        while(key_pressed < 0) {
            getmaxyx(stdscr, window_height, window_width);

            erase();

            draw_game_over(window_height, window_width);

            attron(COLOR_PAIR(c_box));
            box(stdscr, 0, 0);
            attroff(COLOR_PAIR(c_box));

            message[0] = "Press any key";
            print_message(10);

            key_pressed = wgetch(stdscr);
            napms(100);
            key_pressed = wgetch(stdscr);
        }

        clear_message();
    }
}

/* ****************************************
     Helpers
   **************************************** */
void fill_array_with_random_number(int lower, int upper, int numbers[], int count){
    srand(time(NULL));
    for(int i = 0; i < count; i++) {
        numbers[i] = get_random_number(lower, upper);
    }
}

int get_random_number(const int lower, int upper){
    return (rand() % (upper - lower + 1)) + lower;
}

void generate_balls(const int length, char balls[length]){
    char available_balls[] = {s_ball1, s_ball2, s_ball3, s_ball4, s_ball5, s_ball6, s_ball7};
    for(int i = 0; i < length; i++ ){
        balls[i] = available_balls[i];
    }
}

int get_string_length(const char* str) {
    int size = 0;
    while(*str++) ++size;
    return size;
}

int calculate_logo_width() {
    int logo_w_size = 1;

    for (int i = 0; i < logo_height; i++) {
        int len = get_string_length(logo[i]);
        if (len > logo_w_size) {
            logo_w_size = get_string_length(logo[i]);
        }
    }
    return logo_w_size;
}

int calculate_win_width() {
    int win_w_size = 1;

    for (int i = 0; i < win_message_height; i++) {
        int len = get_string_length(win_message[i]);
        if (len > win_w_size) {
            win_w_size = get_string_length(win_message[i]);
        }
    }
    return win_w_size;
}

int calculate_game_over_width() {
    int w_size = 1;

    for (int i = 0; i < game_over_height; i++) {
        int len = get_string_length(game_over[i]);
        if (len > w_size) {
            w_size = get_string_length(game_over[i]);
        }
    }
    return w_size;
}