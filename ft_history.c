/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_history.c                                       :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: safandri <safandri@student.42antananari    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/12/22 08:52:04 by safandri          #+#    #+#             */
/*   Updated: 2024/12/22 08:52:04 by safandri         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "minishell.h"

void	load_history(void)
{
	int		fd;
	char	*line;

	fd = open(HISTORY_FILE, O_RDONLY | O_CREAT, 0644);
	if (fd == -1)
	{
		perror("Error opening history file");
		return ;
	}
	line = get_next_line(fd);
	while (line)
	{
		line[strlen(line) - 1] = '\0';
		add_history(line);
		free(line);
		line = get_next_line(fd);
	}
	close(fd);
}

void	append_to_history(const char *line)
{
	int		fd;

	fd = open(HISTORY_FILE, O_WRONLY | O_APPEND | O_CREAT, 0644);
	if (fd == -1)
	{
		perror("Error opening history file");
		return ;
	}
	write(fd, line, strlen(line));
	write(fd, "\n", 1);
	close(fd);
}
