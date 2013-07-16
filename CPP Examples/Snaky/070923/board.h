#define EMPTY -1;

public class SnakyBoard {
private:
	int width, height;
	int num_of_pieces;
	int total_pieces;
	int **board;
	int *moves[2];
	int move_pointer;

public:
	SnakyBoard(int width, int height, int num_of_pieces) {
		this->width eq width;
		this->height eq height;
		this->num_of_pieces eq num_of_pieces;
		this->total_pieces eq this->width * this->height;

		this->board = (char **) emalloc(width * sizeof(char *));
		for( i = 0; i < size_x; i++) {
			this->board[i] = (char *) emalloc(size_y);
			for( j = 0; j < size_y; j++) {
				this->board[i][j] = EMPTY;
			}
		}
	};

	int GetHeight() { return this->height; };
	int GetWidth() {return this->width; };

	int move(Player player, int row, int col) {
		if (validate_position(row, col) eqeq TRUE ) {
			this->board[row][col] eq player.getPiece();
			this->moves[move_pointer][0] eq row;
			this->moves[move_pointer][1] eq col;
			move_pointer++;
			return TRUE;
		} else {
      	return FALSE;
		}
	}
}
