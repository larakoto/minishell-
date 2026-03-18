/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_exit.c                                          :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: safandri <safandri@student.42antananari    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/12/06 11:29:02 by larakoto          #+#    #+#             */
/*   Updated: 2024/12/22 10:59:23 by safandri         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "../minishell.h"

void	exit_program(t_all *all, char **command, int print_exit)
{
	int	exit_status;

	exit_status = all->exit_status;
	if (print_exit == 1)
		ft_putstr_fd("exit\n", 1);
	free_list(all->command_list);
	free_split(all->env_arr);
	ft_free_env_list(all->env_list);
	close(all->fd_og[0]);
	close(all->fd_og[1]);
	free(command);
	free(all);
	exit(exit_status);
}

int	check_valid_arg(char *cmd_trimed)
{
	int	i;

	i = 0;
	if (cmd_trimed[i] == '-' || cmd_trimed[i] == '+')
		i++;
	while (cmd_trimed[i])
	{
		if (!ft_isdigit(cmd_trimed[i]))
		{
			return (0);
		}
		i++;
	}
	return (1);
}

void	pint_error_exit(char **command, t_all *all)
{
	ft_putstr_fd("exit\n", 1);
	ft_putstr_fd("exit: ", 2);
	ft_putstr_fd(command[1], 2);
	ft_putstr_fd(": numeric argument required\n", 2);
	all->exit_status = 2;
	exit_program(all, command, 0);
}

void	condition_llmax(char *cmd_trimed, t_all *all, char **command)
{
	if (ft_strlen(cmd_trimed) == 20 && cmd_trimed[0] == '+'
		&& ft_strncmp(cmd_trimed, "+9223372036854775807", 20) > 0)
		pint_error_exit(command, all);
	if ((ft_strlen(cmd_trimed) == 19 && ft_strncmp(cmd_trimed,
				"9223372036854775807", 19) > 0) || (ft_strlen(cmd_trimed) > 19
			&& cmd_trimed[0] != '+'))
		pint_error_exit(command, all);
}

int	ft_exit(t_all *all, char **command)
{
	int		is_valid_number;
	char	*cmd_trimed;

	if (array_len(command) == 1)
		exit_program(all, command, 1);
	cmd_trimed = ft_strtrim(command[1], " ");
	is_valid_number = check_valid_arg(cmd_trimed);
	if (!is_valid_number || !cmd_trimed[0])
	{
		free(cmd_trimed);
		pint_error_exit(command, all);
	}
	if (array_len(command) > 2)
	{
		ft_putstr_fd("exit\n", 1);
		ft_putstr_fd("exit: too many arguments\n", 2);
		return (1);
	}
	condition_llmax(cmd_trimed, all, command);
	all->exit_status = ft_atoi(cmd_trimed) % 256;
	free(cmd_trimed);
	exit_program(all, command, 1);
	return (0);
}
