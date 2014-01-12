module ApplicationHelper

		def round n
				number_with_precision(n, :precision => 1)
		end
end
