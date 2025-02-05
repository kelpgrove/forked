$gtk.reset
# $story = nil

module Forked

  # manages the story data
  class Story
    attr_gtk

    def tick
      defaults unless args.state.forked.defaults_set

      check_input

      @display ||= Display.new(THEME)
      @display.args = args
      @display.tick

      present args

      @author ||= Author.new(self)
      @author.args = args
      @author.tick
    end

    def defaults
      
      story_text = fetch_story args
      args.state.forked.story = Parser.parse(story_text)

      args.state.forked.root_chunk = args.state.forked.story[:chunks][0]
      args.state.forked.title = args.state.forked.story[:title]

      follow args
      
      args.state.forked.defaults_set = true

      navigate(0)
    end

    ## input for Forked
    def check_input
      # toggle author mode
      if  args.inputs.keyboard.key_held.f &&
          args.inputs.keyboard.key_down.u
        args.state.forked.author_mode = !args.state.forked.author_mode
        puts "Forked Author Mode is " + (args.state.forked.author_mode ? "on" : "off")
      end
    end

    ### Chunk content

    def heading
      args.state.forked.current_chunk[:content][0][:text]
    end

    def heading_set new_heading
      args.state.forked.current_chunk[:content][0][:text] = new_heading
    end

    ### Navigation

    def get_current_chunk_idx
      args.state.forked.story.chunks.find_index { |c| c == state.forked.current_chunk }
    end

    def find_chunk_index_from_id(chunk_id)
      args.state.forked.story.chunks.index { |i| i[:id] == chunk_id }
    end

    # accepts chunk ID, finds the chunk index and calls navigate()
    def navigate_id(chunk_id)
      idx = find_chunk_index_from_id(chunk_id)
      navigate(idx)
    end

    # accepts an int relative to the current chunk index and calls navigate()
    def navigate_relative(relative_idx)
      next_index = (get_current_chunk_idx + relative_idx).clamp(0, args.state.forked.story.chunks.size - 1)
      navigate(next_index)
    end

    # navigates to the chunk with the provided index number
    def navigate(idx)
      target = args.state.forked.story.chunks[idx]

      if target.nil?
        raise "FORKED: TARGET NOT FOUND. "\
        "Cannot navigate to the specified chunk."
      end

      history_add(idx)

      # set the current chunk
      state.forked.current_chunk = target
      # update the current heading
      @heading = args.state.forked.current_chunk[:content][0][:text]
      args.state.forked.current_heading = @heading || '' 
      # set the current content
      args.state.forked.current_lines = args.state.forked.current_chunk[:content]
      # clear the options array
      args.state.forked.options = []

      process_new_chunk
    end

    # Jump to a specified label
    def jump param
      if param.is_a?(Integer)
        navigate_relative(param)
      elsif param.is_a?(String)
        # TODO: Check that label exists
        navigate_id(param)
      end
    end

    def history_add(target)
      args.state.forked.forked_history ||= [] 
      args.state.forked.forked_history << target
    end

    def history(idx = nil)
      history = args.state.forked.forked_history
      return history unless idx

      history[idx]
    end

    ### Actions

    def process_action(args, action)
      if action.class == String
        if action == '#'
          navigate_relative(1)
        elsif action.start_with?('#')
          navigate_id(action)
        else
          action.delete_prefix!('@@@@')
          evaluate(args, action.to_s)
          return
        end
      else
        raise "Forked: Unexpected action value. Expecting String or Integer. #{action.to_s}"
      end
    end

    def process_new_chunk
      unless args.state.forked.current_chunk.actions.empty?
        args.state.forked.current_chunk.actions.each do |a|
          evaluate args, a
        end
      end
      if args.state.forked.current_lines.nil?
        raise "FORKED Display: The story chunk does not exist.
Check that the chunk_id you are linking to exists and is typed correctly.
Tell Akz to write a better error message."
      end
      if args.state.forked.current_lines.empty?
        raise "No lines were found in the current story chunk. Current chunk is #{args.state.current_chunk}"
      end
    end

    def follow(args, option = nil)
      process_action(args, option.action) if option&.action
    end

#     def follownnnnn(args, option = nil)
#       # todo: move to display and remove this method
#       if option.action
#         process_action(args, option.action)
#       end

#       return

#       # if action is not a chunk ID
#       if option&.action && !option.action.start_with?("#")
#         # @@@@ was added to code to prevent it being confused with a #navigational_action.
#         # The @@@@ part needs to be removed now.
#         # Seems to work but I don't trust it
#         option.action.delete_prefix!('@@@@')
#         evaluate(args, option.action.to_s)
#         return
#       end

#       if option&.action&.size == 1
#         # given ID is just a `#`, fall through
#         fall
#         return
#       end

#       # navigate (set the current chunk to the desired chunk)
#       if option
#         chunk = args.state.forked.story.chunks.select { |k| k[:id] == option.action }[0]
#         if chunk.nil?
#           raise "FORKED: TARGET NOT FOUND. "\
#           "Attempting to navigate to `#{option.action}` but the a chunk_id with that name was not found. "\
#           "Please check that the chunk_id exists."
#         end
#         args.state.forked.current_chunk = chunk
#       else
#         args.state.forked.current_chunk = args.state.forked.root_chunk
#       end

#       print "!!!!"
#       # history_add(args.state.forked.current_chunk[:id])
#       @heading = args.state.forked.current_chunk[:content][0][:text] 
      
#       args.state.forked.current_lines = args.state.forked.current_chunk[:content]
#       args.state.forked.options = []
#       args.state.forked.current_heading = args.state.forked.current_chunk[:heading] || ''

#       unless args.state.forked.current_chunk.actions.empty?
#         args.state.forked.current_chunk.actions.each do |a|
#           evaluate args, a
#         end
#       end
#       if args.state.forked.current_lines.nil?
#         raise "FORKED Display: The story chunk does not exist.
# Check that the chunk_id you are linking to exists and is typed correctly.
# Tell Akz to write a better error message."
#       end
#       if args.state.forked.current_lines.empty?
#         raise "No lines were found in the current story chunk. Current chunk is #{args.state.current_chunk}"
#       end
#     end
 
    def fall
      navigate_relative(1)
    end

    def rise
      navigate_relative(-1)
    end

    def present(args)
      display_lines = args.state.forked.current_lines.copy

      display_lines.each do |element|

        # deal first with content that contains atoms
        if element[:atoms]

          element[:atoms].each_with_index do |atom, j|
            next unless atom[:condition] &&
                        atom[:condition].class == String &&
                        !atom[:condition].empty?
            result = evaluate(args, atom[:condition])
            if result.class == String
              element[:atoms][j][:text] = "#{result} "
            elsif result.nil? || result == false
              element[:atoms][j][:text] = ''
            end
          end
        else
          # the element does not contain atoms
          next unless element && element[:condition]

          result = evaluate(args, element[:condition])

          if result.nil? || result == false
            element[:type] = :blank
          end
        end
      end

      @display.update(display_lines)
    end

    def fetch_story args
      story_text = args.gtk.read_file STORY_FILE

      if story_text.nil?
        raise "The file #{STORY_FILE} failed to load. Please check the filename and path."
      end

      story_text
    end

    #####################
    # EXECUTION
    #####################

    def evaluate(args, command)
      puts "Evaluating: #{command}" if args.state.forked.forked_show_eval
      eval(command)
    end

    def change_theme theme
      @display.apply_theme(theme)
    end
  end
end
