/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_strlen.c                                        :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: larakoto < larakoto@student.42antananar    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/02/20 15:07:23 by safandri          #+#    #+#             */
/*   Updated: 2024/12/22 10:48:47 by larakoto         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "libft.h"

size_t	ft_strlen(const char *str)
{
	size_t	i;

	if (!str)
	{
		return (0);
	}
	i = 0;
	while (str && str[i])
		i++;
	return (i);
}
