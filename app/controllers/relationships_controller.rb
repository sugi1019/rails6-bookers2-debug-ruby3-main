class RelationshipsController < ApplicationController
  def create
    @user = User.find(params[:user_id])  # フォローする対象のユーザーを取得
    current_user.follow(@user)  # ログインユーザーがフォロー
    redirect_back fallback_location: users_path
  end

  def destroy
    @user = User.find(params[:user_id])  # フォロー解除する対象のユーザーを取得
    current_user.unfollow(@user)  # ログインユーザーがフォロー解除
    redirect_back fallback_location: users_path
  end
end