import 'imba-router'

import { Home } from './Home'

export tag App

	def render
		<self.vbox>
			<Home[data] route=''>