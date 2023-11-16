//
//  PostCardService.swift
//  YeeHaw
//
//  Created by Quade Witt on 11/7/23.
//

import Foundation
import Firebase
import SwiftUI


class PostCardService : ObservableObject{
    @Published var post: PostModel!
    @Published var isLiked = false
    @Published var isDisliked = false
    
    func hasLikedPost(){
        isLiked = (post.likes["\(Auth.auth().currentUser!.uid)"] == true)
        ? true: false
    }
    
    func hasDislikedPost(){
        isDisliked = (post.dislikes["\(Auth.auth().currentUser!.uid)"] == true)
        ? true: false
    }
    
    
    func like(){
        post.likeCount += 1
        isLiked = true
        
        PostService.PostsUserId(userId: post.ownerId).collection("posts").document(post.postId)
            .updateData(["likeCount": post.likeCount, "\(Auth.auth().currentUser!.uid)": true])
            
        PostService.AllPosts.document(post.postId).updateData(["likeCount": post.likeCount, "\(Auth.auth().currentUser!.uid)": true])
        
        PostService.timelineUserId(userId: post.ownerId).collection("timeline").document(post.postId).updateData(["likeCount": post.likeCount, "likes.\(Auth.auth().currentUser!.uid)": true])
    }
    
    func dislike() {
        post.dislikeCount += 1
        isDisliked = true
        
        PostService.PostsUserId(userId: post.ownerId).collection("posts").document(post.postId)
            .updateData(["dislikeCount": post.dislikeCount, "\(Auth.auth().currentUser!.uid)": true])
            
        PostService.AllPosts.document(post.postId).updateData(["dislikeCount": post.dislikeCount, "\(Auth.auth().currentUser!.uid)": true])
        
        PostService.timelineUserId(userId: post.ownerId).collection("timeline").document(post.postId).updateData(["dislikeCount": post.dislikeCount, "\(Auth.auth().currentUser!.uid)": true])
    }
    
    func unlike() {
        post.likeCount -= 1
        isLiked = false
        
        PostService.PostsUserId(userId: post.ownerId).collection("posts").document(post.postId)
            .updateData(["likeCount": post.likeCount, "\(Auth.auth().currentUser!.uid)": false])
            
        PostService.AllPosts.document(post.postId).updateData(["likeCount": post.likeCount, "\(Auth.auth().currentUser!.uid)": false])
        
        PostService.timelineUserId(userId: post.ownerId).collection("timeline").document(post.postId).updateData(["likeCount": post.likeCount, "likes.\(Auth.auth().currentUser!.uid)": false])
    }
    func undislike() {
        post.dislikeCount -= 1
        isDisliked = false
        
        PostService.PostsUserId(userId: post.ownerId).collection("posts").document(post.postId)
            .updateData(["dislikeCount": post.dislikeCount, "likes.\(Auth.auth().currentUser!.uid)": false])
            
        PostService.AllPosts.document(post.postId).updateData(["dislikeCount": post.dislikeCount, "\(Auth.auth().currentUser!.uid)": false])
        
        PostService.timelineUserId(userId: post.ownerId).collection("timeline").document(post.postId).updateData(["dislikeCount": post.dislikeCount, "\(Auth.auth().currentUser!.uid)": false])
    }
}
