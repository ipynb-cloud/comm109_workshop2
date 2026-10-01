import random

upper_rows =  [ '1', # ONES'
                '2', # TWOS'
                '3', # THREES'
                '4', # FOURS'
                '5', # FIVES'
                '6'] # SIXES'
 
lower_rows = [ 'T', # THREE OF A KIND'
               'F', # FOUR OF A KIND'
               'S', # SHORT STRAIGHT'
               'L', # LONG STRAIGHT'
               'H', # FULL HOUSE'
               'C', # CHANCE'
               'Y'] # YAHTZEE' 

misc_rows = ['UPPER TOTAL',
             'BONUS', 
             'LOWER TOTAL',
             'TOTAL SCORE' ]

char_to_row =  { '1': 'ONES',
                 '2': 'TWOS',
                 '3': 'THREES',
                 '4': 'FOURS',
                 '5': 'FIVES',
                 '6': 'SIXES',
                 'T': 'THREE OF A KIND',
                 'F': 'FOUR OF A KIND',
                 'S': 'SHORT STRAIGHT',
                 'L': 'LONG STRAIGHT',
                 'H': 'FULL HOUSE',
                 'C': 'CHANCE',
                 'Y': 'YAHTZEE' }

row_to_char = { 'ONES': '1',
                'TWOS': '2',
                'THREES': '3',
                'FOURS': '4',
                'FIVES': '5',
                'SIXES': '6',
                'THREE OF A KIND': 'T',
                'FOUR OF A KIND': 'F',
                'SHORT STRAIGHT': 'S',
                'LONG STRAIGHT': 'L',
                'FULL HOUSE': 'H',
                'CHANCE': 'C',
                'YAHTZEE': 'Y'}


def score_upper_section(dice, val):
    score = 0
    return score


def score_3_of_a_kind(dice):
    score = 0
    return score


def score_4_of_a_kind(dice):
    score = 0
    return score


def score_short_straight(dice):
    score = 0
    return score


def score_long_straight(dice):
    score = 0
    return score


def score_full_house(dice):
    score = 0
    return score


def score_chance(dice):
    return score


def score_yahtzee(dice):
    score = 0
    return score


def initialise_game():
    game_state = {}
    return game_state
    

def roll_dice(game_state):
    return


def reset_dice(game_state):
    return


def lock_dice(game_state, dice_to_keep):
    return success


def toggle_dice(game_state, idx):
    return


def get_score(game_state, row_char):
    score = 0
    return score


def update_scorecard(game_state, row_char):
    return True


# optional extensions

def load_existing_game(game_state):
    loaded_game = False
    return loaded_game


def save_score(game_state):
    return


def get_stats(game_state):
    formatted_stats = ""
    return formatted_stats
    