class Float
	def e_floor(int = 0)
		@int = int
		( self * (10 ** @int)).floor * (10 ** (- @int))
		
	end
end
