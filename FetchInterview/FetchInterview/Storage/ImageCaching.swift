//
//  ImageCache.swift
//  FetchInterview
//
//  Created by Zachery Wagner on 11/26/24.
//

import Foundation
import UIKit

/// An interface for Cache that specifies we are cacheing images.
/// The main idea behind this is to make swapping to a non file based cache easy in the future.
public protocol ImageCaching: Cache where T == UIImage {}
