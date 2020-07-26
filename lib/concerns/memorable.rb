module Concerns::Memorable
    def destroy_all
        self.all.clear
    end

    def create(name)
        i = self.new(name)
        i.save
        i
    end
end