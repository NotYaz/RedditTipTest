//
//  FeedVC.swift
//  RedditTipTest
//
//  Created by Ivan Kozlov on 31/03/2019.
//  Copyright © 2019 Reddit. All rights reserved.
//

import UIKit

final class FeedVC: BaseVC {

}

extension FeedVC {

    @IBAction func tipButtonClicked(_ sender: Any) {
        perform(segue: StoryboardSegue.Feed.tipSlidingVC)
    }

}
