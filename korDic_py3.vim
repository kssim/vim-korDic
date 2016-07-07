python3 << endPython

#_*_ coding: utf-8 _*_
BASE_URL = 'http://dic.naver.com/search.nhn'

import re
import vim
from bs4 import BeautifulSoup
from urllib.parse import quote
from urllib.request import urlopen



def get_request_uri(keyword):
	uri = '?dicQuery=%s&query=%s&target=dic&ie=utf8&query_utf=&isOnlyViewEE=' % (keyword, keyword)
	return uri


def get_page_source(keyword):
	response = urlopen(BASE_URL + get_request_uri(keyword))
	soup = BeautifulSoup(response, 'html.parser')
	return soup


def parse_page_source(soup):
	en_dic_section = soup.find('div', class_='en_dic_section')

	source_word = [s_word.span.getText().encode('utf-8') for s_word in en_dic_section.find_all('dt')]
	translated_word = [t_word.getText().strip().encode('utf-8') for t_word in en_dic_section.find_all('dd')]

	return zip(source_word, translated_word)


def get_result(result_tuple):
	vim.current.buffer[0] = ''

	for s_word, t_word in result_tuple:
		vim.current.buffer.append(s_word)
		vim.current.buffer.append(t_word)
		vim.current.buffer.append('')


def get_url_encoded_string(translate_string):
	return quote(translate_string)


def search_word():
	current_word = vim.eval('expand("<cword>")')
	encoded_word = get_url_encoded_string(current_word)

	soup = get_page_source(encoded_word)
	result_tuple = parse_page_source(soup)

	create_result_window()
	get_result(result_tuple)


def create_result_window():
	go_to_last_window()
	vim.command(':set splitright')
	vim.command(':vnew')


def close_result_windows():
	vim.command(':q!')


def go_to_last_window():
	vim.command(':wincmd b')
endPython


function! Search()
	py3 search_word()
endfunction

function! CloseTab()
	py3 close_result_windows()
endfunction


command! TSearch call Search()
command! TClose call CloseTab()
