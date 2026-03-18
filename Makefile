# ============================================================================
#                           MINISHELL MAKEFILE
# ============================================================================

# Compiler and flags
CC                  := gcc
CFLAGS              := -Wall -Werror -Wextra
DEBUG_FLAGS         := -g -O0 -DDEBUG
OPTIMIZE_FLAGS      := -O2
INCLUDE             := -I.
LDFLAGS             := -lreadline

# Directories
LIBFT_PATH          := ./libft
LIBFT_ARCHIVE       := $(LIBFT_PATH)/libft.a

# Output
NAME                := minishell
OBJ_DIR             := build
BUILD_DIR           := $(OBJ_DIR)

# ============================================================================
#                           SOURCE FILES
# ============================================================================

# Export sources
EXPORT_SRCS         := ./builtins/export_srcs/ft_export.c \
                       ./builtins/export_srcs/ft_export_utils.c \
                       ./builtins/export_srcs/ft_export_error.c

# Environment sources
ENV_SRCS            := ./builtins/env_srcs/ft_env.c \
                       ./builtins/env_srcs/ft_env_utils.c \
                       ./builtins/env_srcs/ft_env_utils_2.c

# Builtins sources
BUILTINS_SRCS       := $(EXPORT_SRCS) $(ENV_SRCS) \
                       ./builtins/ft_unset.c \
                       ./builtins/pwd_cd.c \
                       ./builtins/ft_exit.c \
                       ./builtins/ft_echo.c

# Environment parser sources
ENV_PARSER          := ./parse_srcs/env_parser/ft_env_parser.c \
                       ./parse_srcs/env_parser/ft_env_getter.c \
                       ./parse_srcs/env_parser/ft_env_setter.c

# Split parser sources
SPLIT_2_PARSER      := ./parse_srcs/split_2_parser/ft_split_esc_2.c \
                       ./parse_srcs/split_2_parser/ft_split_2_words_ounter.c \
                       ./parse_srcs/split_2_parser/ft_split_2_utils.c \
                       ./parse_srcs/split_2_parser/ft_split_arg_type.c

# Validator sources
VALIDATOR_SRC       := ./cmd_validation_src/ft_check_valid_commad.c \
                       ./cmd_validation_src/ft_validator_utils.c \
                       ./cmd_validation_src/ft_validator_checker.c

# Heredoc sources
HEREDOC_SRCS        := ./heredoc_srcs/ft_heredoc.c \
                       ./heredoc_srcs/ft_heredoc_utils.c

# Parser sources
PARS_SRCS           := $(ENV_PARSER) $(SPLIT_2_PARSER) \
                       ./parse_srcs/ft_split_esc.c \
                       ./parse_srcs/ft_split_utils.c

# Execution sources
EXEC_SRCS           := ./exec_srcs/ft_exec.c \
                       ./exec_srcs/ft_exec_builtins.c \
                       ./exec_srcs/ft_bin_path.c \
                       ./exec_srcs/ft_exec_fd_utils.c \
                       ./exec_srcs/exec_error.c \
                       ./exec_srcs/exec_geter.c \
                       ./exec_srcs/exec_non_forked.c \
                       ./exec_srcs/exec_non_forked_heredoc.c

# Redirection sources
REDIR_SRCS          := ./redirection_srcs/ft_redirect.c \
                       ./redirection_srcs/redirect_get_set.c

# Utility sources
FREE_UTILS          := ./utils/ft_free.c \
                       ./utils/ft_list_utils.c \
                       ./utils/ft_array_utils.c

# Core sources
CORE_SRCS           := ft_init.c \
                       ft_signals.c \
                       ft_error.c \
                       ft_history.c \
                       get_next_line.c \
                       main.c

# All sources
SRCS                := $(CORE_SRCS) \
                       $(HEREDOC_SRCS) \
                       $(REDIR_SRCS) \
                       $(BUILTINS_SRCS) \
                       $(EXEC_SRCS) \
                       $(VALIDATOR_SRC) \
                       $(FREE_UTILS) \
                       $(PARS_SRCS)

# Object files
OBJS                := $(addprefix $(BUILD_DIR)/,$(SRCS:.c=.o))

# ============================================================================
#                           RULES
# ============================================================================

# Colors for output
RED                 := \033[0;31m
GREEN               := \033[0;32m
YELLOW              := \033[0;33m
BLUE                := \033[0;34m
NC                  := \033[0m

all: $(NAME)

$(NAME): $(LIBFT_ARCHIVE) $(BUILD_DIR) $(OBJS)
	@echo "$(BLUE)Linking $(NAME)...$(NC)"
	@$(CC) $(CFLAGS) $(OBJS) $(LIBFT_ARCHIVE) -o $(NAME) $(LDFLAGS)
	@echo "$(GREEN)✓ $(NAME) created successfully!$(NC)"

$(BUILD_DIR):
	@mkdir -p $(BUILD_DIR)
	@mkdir -p $(BUILD_DIR)/builtins/export_srcs
	@mkdir -p $(BUILD_DIR)/builtins/env_srcs
	@mkdir -p $(BUILD_DIR)/parse_srcs/env_parser
	@mkdir -p $(BUILD_DIR)/parse_srcs/split_2_parser
	@mkdir -p $(BUILD_DIR)/cmd_validation_src
	@mkdir -p $(BUILD_DIR)/heredoc_srcs
	@mkdir -p $(BUILD_DIR)/exec_srcs
	@mkdir -p $(BUILD_DIR)/redirection_srcs
	@mkdir -p $(BUILD_DIR)/utils

$(BUILD_DIR)/%.o: %.c
	@echo "$(YELLOW)Compiling $<...$(NC)"
	@$(CC) $(CFLAGS) $(INCLUDE) -c $< -o $@

$(LIBFT_ARCHIVE):
	@echo "$(BLUE)Building libft...$(NC)"
	@make bonus -C $(LIBFT_PATH)

# Debugging build
debug: CFLAGS += $(DEBUG_FLAGS)
debug: fclean $(NAME)
	@echo "$(GREEN)Debug build complete!$(NC)"

# Optimized build
release: CFLAGS += $(OPTIMIZE_FLAGS)
release: fclean $(NAME)
	@echo "$(GREEN)Release build complete!$(NC)"

# Cleaning rules
clean:
	@echo "$(YELLOW)Cleaning object files...$(NC)"
	@rm -rf $(BUILD_DIR)
	@make clean -C $(LIBFT_PATH)
	@echo "$(GREEN)✓ Clean complete!$(NC)"

fclean: clean
	@echo "$(YELLOW)Full clean...$(NC)"
	@rm -f $(NAME)
	@rm -f .shell_history
	@make fclean -C $(LIBFT_PATH)
	@echo "$(GREEN)✓ Full clean complete!$(NC)"

re: fclean all

# Phony targets
.PHONY: all debug release clean fclean re
