class TasksController < ApplicationController
    def create
        # @category = Category.find(params[:category_id])
        @category = current_user.categories.find(params[:category_id])
        @task = @category.tasks.create(task_params)
    
        redirect_to category_path(@category)
    end

    # def edit
    # end

    # def update

    #     if @task.update(task_params)
    #         redirect_to category_path(@category)
    #     else
    #         render :edit
    #     end
    # end


    def destroy
        # @category = Category.find(params[:category_id])
        @category = current_user.categories.find(params[:category_id])
        @task = @category.tasks.find(params[:id])
        @task.destroy
        redirect_to category_path(@category)
    end

    def due_today
        @due_today = current_user.tasks.where(deadline: Date.current)
        @category = current_user.categories.where(deadline: Date.current)
    end

    
    private
        def task_params
        params.require(:task).permit(:title, :details, :deadline)
        end
end