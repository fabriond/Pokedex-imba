import { Page } from './Page'
import { Pokemon } from './Pokemon'
import { Stores } from '../controllers/Store'

export tag Home < Page
	const detail_state = Stores.new()
	const row_height = 40
	prop loading default: false

	def load
		await data.load_more_pokemon
		while row_height * data.filtered_list:length < window:innerHeight
			await data.load_more_pokemon

	def onscroll e
		let event_target = e.event:target
		let scroll_percentage = event_target:scrollTop / event_target:scrollTopMax

		if scroll_percentage > 0.9 && !@loading
			@loading = true
			await data.load_more_pokemon
			@loading = false

	def render
		<self>
			<aside>
				<input[data.states:filter].search>
				<ul.entries>
					for pokemon in data.filtered_list
						<li.entry route-to=pokemon:id>
							<span.name> pokemon:name
			
			<Pokemon[detail_state] route=':id'>