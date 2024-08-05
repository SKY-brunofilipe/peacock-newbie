//
//  SectionDTOMapping.swift
//  Peacock-Newbie
//
//  Created by Bruno Filipe on 29/07/2024.
//

import Foundation

struct SectionResponseDTO: Decodable {
    let data: SectionGroupDTO
}

extension SectionResponseDTO {
    struct SectionGroupDTO: Decodable {
        let group: SectionDTO
    }
    
    struct SectionDTO: Decodable {
        let type: String
        let rails: [CollectionRailDTO]
        let id: String
        let title: String
    }
    
    struct CollectionRailDTO: Decodable {
        enum RailTypeDTO: String, Decodable {
            case catalogueCollection = "CATALOGUE/COLLECTION"
            case catalogueLink = "CATALOGUE/LINK"
       }
        let id: String
        let type: RailTypeDTO
        let title: String
        let renderHint: RenderHintDTO
        let items: [AssetDTO]?
    }
    
    struct RenderHintDTO: Decodable {
        enum TemplateDTO: String, Decodable {
            case HIGHLIGHT
            case DEFAULT
            case CONTINUE_WATCHING
            case WATCHLIST
            case GRID
            case LIVE
        }
        let orientation: String?
        let template: TemplateDTO?
        let hideTitle: Bool?
        let hideLogo: Bool?
        let sort: Bool?
        let groupTemplate: String?
    }
    
    struct AssetDTO: Decodable {
        let id: String
        let type: String
        let title: String
        let images: [ImageDTO]
        let synopsisLong: String?
    }
    
    struct ImageDTO: Decodable {
        enum ImageTypeDTO: String, Decodable {
            case landscape
            case titleArt169
            case nonTitleArt34
            case titleArt34
            case titleLogo
            case scene34
            case railBackground
            case tile
            case backgroundUnfocus
            case backgroundFocus
            case connectUnfocus
            case connectFocus
            case background
            case icon
            case heroThumbnail = "HERO_THUMBNAIL"
        }
        enum ImageAreaDTO: String, Decodable {
            case heroThumbnail = "HERO_THUMBNAIL"
        }
        let type: ImageTypeDTO
        let url: String
        let area: ImageAreaDTO?
    }
}

extension SectionResponseDTO {
    func toDomain() -> SectionResponse {
        .init(data: data.toDomain())
    }
}

extension SectionResponseDTO.SectionGroupDTO {
    func toDomain() -> SectionGroup {
        .init(group: group.toDomain())
    }
}

extension SectionResponseDTO.SectionDTO {
    func toDomain() -> Section {
        .init(
            rails: rails.map{ $0.toDomain() },
            id: id,
            title: title,
            type: type
        )
    }
}

extension SectionResponseDTO.CollectionRailDTO {
    func toDomain() -> CollectionRail {
        .init(
            id: id,
            type: type.toDomain(),
            title: title,
            renderHint: renderHint.toDomain(),
            items: items?.map{ $0.toDomain() }
        )
    }
}

extension SectionResponseDTO.CollectionRailDTO.RailTypeDTO {
    func toDomain() -> RailType {
        switch self {
        case .catalogueCollection: return .catalogueCollection
        case .catalogueLink: return .catalogueLink
        }
    }
}

extension SectionResponseDTO.RenderHintDTO {
    func toDomain() -> RenderHint {
        .init(
            orientation: orientation,
            template: template?.toDomain(),
            groupTemplate: groupTemplate,
            hideTitle: hideTitle,
            hideLogo: hideLogo,
            sort: sort
        )
    }
}

extension SectionResponseDTO.RenderHintDTO.TemplateDTO {
    func toDomain() -> RenderHint.Template {
        switch self {
        case .HIGHLIGHT: return .HIGHLIGHT
        case .DEFAULT: return .DEFAULT
        case .CONTINUE_WATCHING: return .CONTINUE_WATCHING
        case .WATCHLIST: return .WATCHLIST
        case .GRID: return .GRID
        case .LIVE: return .LIVE
        }
    }
}

extension SectionResponseDTO.AssetDTO {
    func toDomain() -> Asset {
        .init(
            type: type,
            id: id,
            title: title,
            images: images.map { $0.toDomain() },
            synopsisLong: synopsisLong
        )
    }
}

extension SectionResponseDTO.ImageDTO {
    func toDomain() -> Image {
        .init(
            type: type.toDomain(),
            url: url,
            area: area?.toDomain()
        )
    }
}

extension SectionResponseDTO.ImageDTO.ImageTypeDTO {
    func toDomain() -> Image.ImageType {
        switch self {
        case .landscape: return .landscape
        case .titleArt169: return .titleArt169
        case .nonTitleArt34: return .nonTitleArt34
        case .titleArt34: return .titleArt34
        case .titleLogo: return .titleLogo
        case .scene34: return .scene34
        case .railBackground: return .railBackground
        case .heroThumbnail: return .heroThumbnail
        case .tile: return .tile
        case .backgroundUnfocus: return .backgroundUnfocus
        case .backgroundFocus: return .backgroundFocus
        case .connectUnfocus: return .connectUnfocus
        case .connectFocus: return .connectFocus
        case .background: return .background
        case .icon: return .icon
        }
    }
}

extension SectionResponseDTO.ImageDTO.ImageAreaDTO {
    func toDomain() -> Image.ImageArea {
        switch self {
            case .heroThumbnail: return .heroThumbnail
        }
    }
}
