class Task < ActiveRecord::Base
  validates(:description, {:presence => true, :length => { :maximum => 50 }})
  belongs_to(:list)
  scope(:not_done, -> do
    where({:done => false})
  end)
end
