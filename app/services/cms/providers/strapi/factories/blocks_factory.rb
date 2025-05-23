module Cms
  module Providers
    module Strapi
      module Factories
        module BlocksFactory
          include BaseFactory

          def self.generate_component(component_name, strapi_data)
            case component_name
            when "full-width-banner"
              to_full_width_banner(strapi_data)
            when "full-width-text"
              to_full_width_text(strapi_data)
            when "horizontal-card"
              to_horizontal_card(strapi_data)
            when "numbered-icon-list"
              to_numbered_icon_list(strapi_data)
            when "numeric-cards-section"
              to_card_wrapper(strapi_data, to_numeric_card_array(strapi_data[:numericCards]))
            when "picture-card-section"
              to_card_wrapper(strapi_data, to_picture_card_array(strapi_data[:pictureCards]))
            when "question-and-answer"
              to_question_and_answer(strapi_data)
            when "resource-card-section"
              to_card_wrapper(strapi_data, to_resource_card_array(strapi_data[:resourceCards]))
            when "course-cards-section"
              to_card_wrapper(strapi_data, to_course_card_array(strapi_data[:cards]))
            when "split-horizontal-card"
              to_split_horizontal_card(strapi_data)
            when "testimonial-row"
              to_testimonial_row(strapi_data)
            when "text-with-asides"
              to_text_with_asides(strapi_data)
            when "community-activity-list"
              to_community_activity_list(strapi_data)
            when "sticky-dashboard-bar"
              Models::DynamicComponents::Blocks::StickyDashboardBar.new(programme_slug: strapi_data[:programme][:data][:attributes][:slug])
            when "enrolment-testimonial"
              to_enrolment_testimonial(strapi_data)
            when "enrolment-split-course-card"
              to_enrolment_split_course_card(strapi_data)
            when "icon-row"
              to_icon_row(strapi_data)
            when "two-column-video-section"
              to_two_column_video_section(strapi_data)
            when "homepage-hero"
              to_homepage_hero(strapi_data)
            when "featured-blogs"
              Models::DynamicComponents::Blocks::FeaturedBlogs.new(title: strapi_data[:title])
            when "banner-with-cards"
              to_banner_with_cards(strapi_data)
            when "text-with-testimonial"
              to_text_with_testimonial(strapi_data)
            when "primary-glossary-table"
              Models::DynamicComponents::Blocks::PrimaryGlossaryTable.new(title: strapi_data[:title])
            when "two-column-picture-section"
              to_two_column_picture_section(strapi_data)
            when "video-cards-section"
              to_card_wrapper(strapi_data, to_video_card_array(strapi_data[:videoCards]))
            when "full-width-image-banner"
              to_full_width_image_banner(strapi_data)
            when "horizontal-card-with-asides"
              to_horizontal_card_with_asides(strapi_data)
            when "prog-picture-card-secs"
              to_programme_card_wrapper(strapi_data)
            when "secondary-question-bank"
              Models::DynamicComponents::Blocks::SecondaryQuestionBank.new(title: strapi_data[:title])
            when "button-block"
              to_button_block(strapi_data)
            when "feedback-banner"
              to_feedback_banner(strapi_data)
            when "curriculum-key-stages"
              to_curriculum_key_stages(strapi_data)
            when "accordion-section"
              to_accordion_section(strapi_data, to_accordion_block_array(strapi_data[:accordionBlocks]))
            when "prog-resource-card-secs"
              to_programme_card_wrapper(strapi_data)
            end
          end

          def self.to_accordion_section(strapi_data, accordion_blocks)
            Models::DynamicComponents::Blocks::AccordionSection.new(
              id: strapi_data[:id],
              title: strapi_data[:title],
              background_color: extract_color_name(strapi_data, :bkColor),
              accordion_blocks:
            )
          end

          def self.to_accordion_block_array(strapi_data)
            strapi_data.map do |accordion_block|
              Models::DynamicComponents::ContentBlocks::AccordionBlock.new(
                id: accordion_block[:id],
                heading: accordion_block[:heading],
                summary_text: accordion_block[:summaryText],
                text_content: to_content_block(accordion_block[:textContent])
              )
            end
          end

          def self.to_feedback_banner(strapi_data)
            Models::DynamicComponents::Blocks::FeedbackBanner.new(
              title: strapi_data[:title],
              button: to_ncce_button(strapi_data[:button])
            )
          end

          def self.to_button_block(strapi_data)
            Models::DynamicComponents::Blocks::ButtonBlock.new(
              buttons: strapi_data[:buttons].map { to_ncce_button(_1) },
              background_color: extract_color_name(strapi_data, :bkColor),
              padding: strapi_data[:padding],
              alignment: strapi_data[:alignment],
              full_width: strapi_data[:fullWidth]
            )
          end

          def self.to_text_with_testimonial(strapi_data)
            Models::DynamicComponents::Blocks::TextWithTestimonial.new(
              text_content: to_content_block(strapi_data[:textContent]),
              background_color: extract_color_name(strapi_data, :bkColor),
              testimonial: to_testimonial(strapi_data[:testimonial]),
              testimonial_side: strapi_data[:testimonialSide],
              buttons: strapi_data[:buttons] ? strapi_data[:buttons].map { to_ncce_button(_1) } : []
            )
          end

          def self.to_curriculum_key_stages(strapi_data)
            Models::DynamicComponents::Blocks::CurriculumKeyStages.new(
              title: strapi_data[:title],
              background_color: extract_color_name(strapi_data, :bkColor)
            )
          end

          def self.to_full_width_image_banner(strapi_data)
            Models::DynamicComponents::Blocks::FullWidthImageBanner.new(
              background_image: to_image(strapi_data, :backgroundImage, default_size: :original),
              overlay_title: strapi_data[:overlayTitle],
              overlay_text: to_content_block(strapi_data[:overlayText], paragraph_class: "govuk-body-s"),
              overlay_icon: to_image(strapi_data, :overlayIcon, default_size: :small),
              overlay_side: strapi_data[:overlaySide]
            )
          end

          def self.to_horizontal_card_with_asides(strapi_data)
            Models::DynamicComponents::Blocks::HorizontalCardWithAsides.new(
              text: to_content_block(strapi_data[:textContent]),
              button: to_ncce_button(strapi_data[:button]),
              aside_sections: extract_aside_sections(strapi_data, param_name: :asides),
              background_color: extract_color_name(strapi_data, :bkColor),
              color_theme: extract_color_name(strapi_data, :theme)
            )
          end

          def self.to_icon_row(strapi_data)
            Models::DynamicComponents::Blocks::IconRow.new(
              icons: strapi_data[:icons].map { to_icon(_1) },
              background_color: extract_color_name(strapi_data, :bkColor)
            )
          end

          def self.to_two_column_picture_section(strapi_data)
            Models::DynamicComponents::Blocks::TwoColumnPictureSection.new(
              text: to_content_block(strapi_data[:textContent]),
              image: to_image(strapi_data, :image),
              image_side: strapi_data[:imageSide],
              background_color: extract_color_name(strapi_data, :bkColor),
              banner: EmbedBlocksFactory.to_side_banner(strapi_data, :banner),
              section_title: EmbedBlocksFactory.to_section_title(strapi_data)
            )
          end

          def self.to_two_column_video_section(strapi_data)
            Models::DynamicComponents::Blocks::TwoColumnVideoSection.new(
              left_column_content: to_content_block(strapi_data[:leftColumnContent], list_class: "numbered-points"),
              video: to_embedded_video(strapi_data[:video]),
              right_column_content: to_content_block(strapi_data[:rightColumnContent], list_class: "numbered-points"),
              background_color: extract_color_name(strapi_data, :bkColor),
              left_column_button: to_ncce_button(strapi_data[:leftColumnButton]),
              box_color: extract_color_name(strapi_data, :boxColor),
              video_side: strapi_data[:videoSide],
              section_title: EmbedBlocksFactory.to_section_title(strapi_data)
            )
          end

          def self.to_banner_with_cards(strapi_data)
            Models::DynamicComponents::Blocks::BannerWithCards.new(
              title: strapi_data[:title],
              text_content: to_content_block(strapi_data[:textContent]),
              background_color: extract_color_name(strapi_data, :bkColor),
              cards: to_horizontal_link_card_array(strapi_data[:cards])
            )
          end

          def self.to_homepage_hero(strapi_data)
            Models::DynamicComponents::Blocks::HomepageHero.new(
              title: strapi_data[:title],
              house_content: to_content_block(strapi_data[:houseText]),
              buttons: strapi_data[:buttons] ? strapi_data[:buttons].map { to_ncce_button(_1) } : []
            )
          end

          def self.to_enrolment_split_course_card(strapi_data)
            Models::DynamicComponents::Blocks::EnrolmentSplitCourseCard.new(
              card_content: to_content_block(strapi_data[:cardContent]),
              aside_content: to_content_block(strapi_data[:asideContent]),
              enrol_aside: extract_aside_sections(strapi_data, param_name: :enrolAside),
              section_title: strapi_data[:sectionTitle],
              background_color: extract_color_name(strapi_data, :bkColor),
              color_theme: extract_color_name(strapi_data, :colorTheme),
              aside_title: strapi_data[:asideTitle],
              aside_icon: to_image(strapi_data, :asideIcon),
              programme_slug: strapi_data[:programme][:data][:attributes][:slug]
            )
          end

          def self.to_enrolment_testimonial(strapi_data)
            Models::DynamicComponents::Blocks::EnrolmentTestimonial.new(
              title: strapi_data[:title],
              testimonial: to_testimonial(strapi_data[:testimonial]),
              enrolled_aside: extract_aside_sections(strapi_data, param_name: :enrolledAside),
              enrol_aside: extract_aside_sections(strapi_data, param_name: :enrolAside),
              background_color: extract_color_name(strapi_data, :bkColor),
              programme_slug: strapi_data[:programme][:data][:attributes][:slug]
            )
          end

          def self.to_community_activity_list(strapi_data)
            Models::DynamicComponents::Blocks::CommunityActivityGrid.new(
              title: strapi_data[:title],
              intro: to_content_block(strapi_data[:intro]),
              programme_activity_group_slug: strapi_data[:group][:data][:attributes][:slug]
            )
          end

          def self.to_icon_block(strapi_data)
            Models::DynamicComponents::ContentBlocks::IconBlock.new(icons: strapi_data.map { to_icon(_1) })
          end

          def self.to_numeric_card_array(strapi_data)
            strapi_data.map.with_index do |card_data, index|
              Models::DynamicComponents::ContentBlocks::NumericCard.new(
                title: card_data[:title],
                text_content: to_content_block(card_data[:textContent], paragraph_class: "govuk-body-l"),
                number: index + 1
              )
            end
          end

          def self.to_picture_card_array(strapi_data)
            strapi_data.map do |card_data|
              Models::DynamicComponents::ContentBlocks::PictureCard.new(
                image: to_image(card_data, :image, default_size: :medium),
                title: card_data[:title],
                body_text: to_content_block(card_data[:textContent]),
                link: card_data[:link],
                color_theme: extract_color_name(card_data, :colorTheme)
              )
            end
          end

          def self.to_resource_card_array(strapi_data)
            strapi_data.map do |card_data|
              Models::DynamicComponents::ContentBlocks::ResourceCard.new(
                title: card_data[:title],
                icon: to_image(card_data, :icon, default_size: :medium),
                color_theme: extract_color_name(card_data, :colorTheme),
                body_text: to_content_block(card_data[:textContent]),
                button_text: card_data[:buttonText],
                button_link: card_data[:buttonLink]
              )
            end
          end

          def self.to_course_card_array(strapi_data)
            strapi_data.map do |card_data|
              Models::DynamicComponents::ContentBlocks::CourseCard.new(
                title: card_data[:title],
                banner_text: card_data[:bannerText],
                course_code: card_data[:courseCode],
                description: to_content_block(card_data[:description]),
                image: to_image(card_data, :image, default_size: :medium)
              )
            end
          end

          def self.to_horizontal_link_card_array(strapi_data)
            strapi_data.map do |card_data|
              Models::DynamicComponents::ContentBlocks::HorizontalLinkCard.new(
                title: card_data[:title],
                link_url: card_data[:linkUrl],
                card_content: to_content_block(card_data[:cardContent]),
                theme: extract_color_name(card_data, :theme)
              )
            end
          end

          def self.to_video_card_array(strapi_data)
            strapi_data.map do |card_data|
              Models::DynamicComponents::ContentBlocks::VideoCard.new(
                title: card_data[:title],
                text_content: to_content_block(card_data[:textContent], paragraph_class: "govuk-body-s"),
                video: to_embedded_video({url: card_data[:videoUrl]}),
                name: card_data[:name],
                job_title: card_data[:jobTitle],
                color_theme: extract_color_name(card_data, :colorTheme)
              )
            end
          end

          def self.to_programme_picture_card_array(strapi_data, programme)
            strapi_data.map do |card_data|
              Models::DynamicComponents::ContentBlocks::ProgrammePictureCard.new(
                title: card_data[:title],
                image: to_image(card_data, :image, default_size: :medium),
                text_content: to_content_block(card_data[:textContent]),
                card_links: to_multi_state_link(card_data, programme),
                programme:
              )
            end
          end

          def self.to_programme_resource_card_array(strapi_data, programme_slug)
            programme = Programme.find_by(slug: programme_slug)

            strapi_data.map do |card_data|
              Models::DynamicComponents::ContentBlocks::ProgrammeResourceCard.new(
                title: card_data[:title],
                logged_out_text_content: to_content_block(card_data[:loggedOutTextContent]),
                not_enrolled_text_content: to_content_block(card_data[:notEnrolledTextContent]),
                enrolled_text_content: to_content_block(card_data[:enrolledTextContent]),
                programme: programme,
                color_theme: extract_color_name(card_data, :clrTheme),
                button: to_enrol_button(card_data, programme)
              )
            end
          end

          def self.to_programme_card_wrapper(strapi_data, title_as_paragraph: false)
            programme_slug = extract_programme_slug(strapi_data, :prog)
            programme = Programme.find_by(slug: programme_slug)

            cards_block = if strapi_data[:programmeCards].present?
              to_programme_picture_card_array(strapi_data[:programmeCards], programme)
            elsif strapi_data[:resourceCards].present?
              to_programme_resource_card_array(strapi_data[:resourceCards], programme_slug)
            end

            Models::DynamicComponents::Blocks::ProgrammeCardWrapper.new(
              title: strapi_data[:sectionTitle],
              intro_text: to_content_block(strapi_data[:introText].presence || []),
              cards_block: cards_block,
              cards_per_row: strapi_data[:cardsPerRow].presence || 3,
              background_color: extract_color_name(strapi_data, :bkColor),
              title_as_paragraph:,
              programme:
            )
          end

          def self.to_card_wrapper(strapi_data, cards_block, title_as_paragraph: false)
            Models::DynamicComponents::Blocks::CardWrapper.new(
              title: strapi_data[:sectionTitle],
              intro_text: to_content_block(strapi_data[:introText].presence || []),
              cards_block: cards_block,
              cards_per_row: strapi_data[:cardsPerRow].presence || 3,
              background_color: extract_color_name(strapi_data, :bkColor),
              title_as_paragraph:
            )
          end

          def self.to_full_width_banner(strapi_data)
            Models::DynamicComponents::Blocks::FullWidthBanner.new(
              text_content: to_content_block(strapi_data[:textContent]),
              background_color: extract_color_name(strapi_data, :backgroundColor),
              box_color: extract_color_name(strapi_data, :boxColor),
              image: to_image(strapi_data, :image, default_size: :medium),
              image_side: strapi_data[:imageSide],
              image_link: strapi_data[:imageLink],
              buttons: strapi_data[:buttons] ? strapi_data[:buttons].map { to_ncce_button(_1) } : [],
              title: strapi_data[:sectionTitle],
              show_bottom_border: strapi_data[:showBottomBorder],
              i_belong_flag: strapi_data[:iBelongFlag],
              corner_flourish: strapi_data[:imageCornerFlourish],
              image_fit: strapi_data[:imageFit]
            )
          end

          def self.to_full_width_text(strapi_data)
            Models::DynamicComponents::Blocks::FullWidthText.new(
              blocks: to_content_block(strapi_data[:textContent]),
              background_color: extract_color_name(strapi_data, :backgroundColor),
              show_bottom_border: strapi_data[:showBottomBorder]
            )
          end

          def self.to_horizontal_card(strapi_data)
            Models::DynamicComponents::Blocks::HorizontalCard.new(
              title: strapi_data[:title],
              body_blocks: to_content_block(strapi_data[:textContent]),
              image: to_image(strapi_data, :image, default_size: :small),
              image_link: strapi_data[:imageLink],
              color_theme: extract_color_name(strapi_data, :colorTheme),
              icon_block: to_icon_block(strapi_data[:iconBlock]),
              spacing: strapi_data[:spacing],
              external_title: strapi_data[:externalTitle],
              background_color: extract_color_name(strapi_data, :bkColor),
              buttons: strapi_data[:buttons] ? strapi_data[:buttons].map { to_ncce_button(_1) } : []
            )
          end

          def self.to_numbered_icon_list(strapi_data)
            Models::DynamicComponents::Blocks::NumberedIconList.new(
              title: strapi_data[:title],
              title_icon: to_image(strapi_data, :titleIcon),
              points: strapi_data[:points].map { to_content_block(_1[:textContent]) },
              aside_sections: extract_aside_sections(strapi_data)
            )
          end

          def self.to_question_and_answer(strapi_data)
            Models::DynamicComponents::Blocks::QuestionAndAnswer.new(
              question: strapi_data[:question],
              answer: to_content_block(strapi_data[:answer]),
              aside_sections: extract_aside_sections(strapi_data),
              answer_icon_block: to_icon_block(strapi_data[:answerIcons]),
              aside_alignment: strapi_data[:asideAlignment],
              show_background_triangle: strapi_data[:showBackgroundTriangle]
            )
          end

          def self.to_split_horizontal_card(strapi_data)
            Models::DynamicComponents::Blocks::SplitHorizontalCard.new(
              card_content: to_content_block(strapi_data[:cardContent]),
              aside_content: to_content_block(strapi_data[:asideContent]),
              aside_icon: to_image(strapi_data, :asideIcon),
              aside_title: strapi_data[:asideTitle],
              section_title: strapi_data[:sectionTitle],
              color_theme: extract_color_name(strapi_data, :colorTheme),
              background_color: extract_color_name(strapi_data, :bkColor)
            )
          end

          def self.to_testimonial_row(strapi_data)
            Models::DynamicComponents::Blocks::TestimonialRow.new(
              title: strapi_data[:title],
              background_color: extract_color_name(strapi_data, :backgroundColor),
              testimonials: strapi_data[:testimonials].map { to_testimonial(_1) }
            )
          end

          def self.to_text_with_asides(strapi_data)
            Models::DynamicComponents::Blocks::TextWithAsides.new(
              blocks: to_content_block(strapi_data[:textContent]),
              asides: extract_aside_sections(strapi_data),
              background_color: extract_color_name(strapi_data, :bkColor)
            )
          end
        end
      end
    end
  end
end
