class RelationshipsController < ApplicationController
  def create
    @user = User.find(params[:user_id])  # フォローする対象のユーザーを取得
    current_user.follow(@user)  # ログインユーザーがフォロー
  
    # フォロー後のリダイレクト先（ユーザーの詳細ページなど）
    redirect_to users_path
  end
  # フォローを解除する
  def destroy
    @user = User.find(params[:user_id])  # フォロー解除する対象のユーザーを取得
    current_user.unfollow(@user)  # ログインユーザーがフォロー解除

    # フォロー解除後のリダイレクト先
    redirect_to users_path
  end
end