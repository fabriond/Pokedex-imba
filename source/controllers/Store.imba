export class Stores
	prop states
	
	def initialize
		@states = {}

	def load_more_pokemon
		console.log "Fetching More Pokemon... ({(@states:pokemon_list or []):length} so far)"
		let response = await window.fetch(@states:next_url or 'https://pokeapi.co/api/v2/pokemon/?limit=15')
		let json_data = await response.json
		@states = {
			pokemon_list: (@states:pokemon_list or []).concat(map_pokemon(json_data:results)), 
			next_url: json_data:next, 
			filter: (@states:filter or '')
		}

	def filtered_list
		@states:pokemon_list.filter do $1:name.includes(@states:filter.toLowerCase())

	def load_pokemon_detail id
		console.log "Fetching Data for Pokemon with ID {id}"
		let response = await window.fetch("https://pokeapi.co/api/v2/pokemon/{id}")
		let json_data = await response.json
		json_data:types = json_data:types.sort do $1:slot > $2:slot
		@states = {pokemon_detail: json_data}

	def map_pokemon pokemon_data
		for pokemon in pokemon_data
			let id = pokemon:url.split('/')
			id.pop()
			id = id.pop()
			{id: id, name: pokemon:name, url: pokemon:url}