class TaskSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :completed, :positionX, :positionY, :list_id, :users

  def users
    object.user_tasks.map do |ut|
      UserSerializer.new(ut.user)
    end
  end
end
