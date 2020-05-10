export tag Pokemon
	def load params
		data.load_pokemon_detail params:id

	def render
		<self>
			<h2> data.states:pokemon_detail:name
			<div> <img src=data.states:pokemon_detail:sprites:front_default>
			<section> "types"
				<ul.types>
					for type_data in data.states:pokemon_detail:types
						<li.type.{type_data:type:name}> type_data:type:name