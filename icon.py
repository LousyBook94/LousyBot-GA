from PIL import Image, ImageDraw, ImageFont
import math

def generate_lousybot_icon():
    """Generate a beautiful minimal icon for LousyBot"""
    
    # Icon settings
    size = 256  # High resolution for scaling
    bg_color = (24, 24, 37)  # Dark blue-gray background (liked by user)
    accent_color = (99, 102, 241)  # Soft indigo
    nn_color = (71, 85, 105)  # Very subtle gray for neural network
    
    # Create image
    img = Image.new('RGB', (size, size), bg_color)
    draw = ImageDraw.Draw(img)
    
    center = size // 2
    
    # Add subtle neural network background pattern (properly aligned)
    node_size = 2
    network_spacing = size // 7
    
    # Create a subtle grid of connected nodes (centered)
    for i in range(0, 7):  # Horizontal nodes
        for j in range(0, 7):  # Vertical nodes
            x = center - (network_spacing * 3) + (i * network_spacing)
            y = center - (network_spacing * 3) + (j * network_spacing)
            
            # Draw node
            draw.ellipse([x - node_size, y - node_size,
                          x + node_size, y + node_size],
                         fill=nn_color)
            
            # Connect to adjacent nodes (subtle lines)
            if i < 6:  # Connect to right node
                draw.line([x + node_size, y,
                          x + network_spacing - node_size, y],
                         fill=nn_color, width=1)
            if j < 6:  # Connect to bottom node
                draw.line([x, y + node_size,
                          x, y + network_spacing - node_size],
                         fill=nn_color, width=1)
    
    # Simple circle outline - minimal and friendly
    circle_radius = size // 2 - 20
    draw.ellipse([center - circle_radius, center - circle_radius,
                  center + circle_radius, center + circle_radius],
                 outline=accent_color, width=3)
    
    # Better positioned "L" shape for LousyBot with separate variables
    l_thickness = size // 18  # Good thickness
    
    # Separate variables for vertical and horizontal parts
    vertical_l_size = size // 2.2  # Vertical part length
    horizontal_l_size = size // 3.2  # Horizontal part length
    
    # Lower the L position and center it better
    l_offset_x = 5
    l_offset_y = -5  # Slightly downward offset
    
    # Vertical line of "L" (using separate variable)
    draw.rectangle([center - horizontal_l_size//2 + l_offset_x, center - vertical_l_size//2 + l_offset_y,
                   center - horizontal_l_size//2 + l_thickness + l_offset_x, center + vertical_l_size//2 + l_offset_y],
                  fill=accent_color)
    
    # Horizontal line of "L" (using separate variable)
    draw.rectangle([center - horizontal_l_size//2 + l_offset_x, center + vertical_l_size//2 + l_offset_y,
                   center + horizontal_l_size//2 + l_offset_x, center + vertical_l_size//2 + l_thickness + l_offset_y],
                  fill=accent_color)
    
    # Add a subtle inner glow
    inner_radius = circle_radius - 15
    draw.ellipse([center - inner_radius, center - inner_radius,
                  center + inner_radius, center + inner_radius],
                 outline=accent_color, width=1)
    
    # Save only the main icon
    img.save('icon.png', 'PNG', optimize=True, quality=95)
    print("✅ Beautiful LousyBot icon generated as 'icon.png'!")

if __name__ == "__main__":
    generate_lousybot_icon()